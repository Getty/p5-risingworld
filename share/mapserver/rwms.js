
var RwMapServerPlayer = Class.extend({

  colors: [
    '#FFFF00', // Yellow
    '#FF00FF', // Fuchsia
    '#00FFFF', // Aqua
    '#FFFFFF', // White
    '#808080', // Gray
    '#008080', // Teal
    '#800080', // Purple
  ],

  init: function(cam_node, labels, player, no){
    var self = this;
    self.cam_node = cam_node;
    self.labels = labels;
    self.player_id = player.DBID;
    self.name = player.name;
    self.color = self.colors[no % self.colors.length];
    self.color_gl = self.hex2rgb(self.color);
    self.x = player.chunkPosition.x;
    self.y = player.chunkPosition.y;
    self.z = player.chunkPosition.z;
    self.label = $('<div></div>');
    self.label.css({
      display: 'table-row'
    });
    var inner_label = $('<div>[' + self.name + ']</div>');
    inner_label.css({
      backgroundColor: self.color,
      padding: "8px",
      fontWeight: "bold",
      fontFamily: "'Cabin', Helvetica, Arial, sans-serif"
    });
    self.activity = $('<span/>');
    self.activity.css({
      paddingLeft: "5px"
    });
    self.activity.appendTo(inner_label);
    inner_label.appendTo(self.label);
    self.label.appendTo(self.labels);
    self.node = self.cam_node.addNode({
      type: "translate",
      x: self.x,
      y: self.y,
      z: self.z,
      nodes: [{
        type: "material",
        color: self.color_gl,
        specularColor: { r: 1.0, g: 1.0, b: 1.0 },
        nodes: [{
          type: "style",
          lineWidth: 2,
          nodes: [{
            type: "geometry/sphere",
            latitudeBands: 30, // Default
            longitudeBands: 30, // Default
            radius: 0.5, // Default
            wire: false // Default
          }]
        }]
      }]
    });
  },

 update: function(chunkPosition){
    var self = this;
    self.x = chunkPosition.x;
    self.y = chunkPosition.y;
    self.z = chunkPosition.z;
    self.node.set({
      x: self.x,
      y: self.y * 4,
      z: self.z
    });

    if (self.line) {
      self.line.destroy();
    }
    self.line = self.node.addNode(
      
    {
        type: "material",
        color: self.color_gl,
        specularColor: { r: 1.0, g: 1.0, b: 1.0 },
        nodes: [
          {
            type: "geometry",
            primitive: "lines",
            positions: [0,0,0,
                        0,(self.y * 4) * -1,0],
            indices: [0,1]
          }
        ]
     }
     );
  },

  set_activity: function(activity){
    var self = this;
    self.activity.text(activity);
  },

  destroy: function(){
    var self = this;
    self.node.destroy();
    self.label.remove();
  },

  hex2rgb: function(val){
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(val);
    return result ? {
      r: ( parseInt(result[1], 16) / 255 ),
      g: ( parseInt(result[2], 16) / 255 ),
      b: ( parseInt(result[3], 16) / 255 )
    } : null;
  }

});

var RwMapServer = Class.extend({

  init: function(ws_url, environment_url){
    var self = this;
    self.player_no = 0;
    self.environment_url = environment_url;
    self.ws = $.gracefulWebSocket(ws_url);
    self.ws.onmessage = function (event) {
      var data = $.parseJSON(event.data);
      self.on_event(data);
    };
    self.cam_node_id = 'RwMapServer' + Date.now();
    self.players = {};
    self.setup_scene();
  },

  setup_scene: function() {
    var self = this;
    var config = {
      transparent: true,
      nodes: [{
        type: "cameras/pickFlyOrbit",
        //showCursor: true,
        yaw: 90,
        pitch: -45,
        zoom: 75,
        zoomSensitivity: 20.0,
        nodes: [{ id: self.cam_node_id }]
      }]
    };
    self.scene = SceneJS.createScene(config);
    self.scene.getNode(self.cam_node_id,function(node){
      self.cam_node = node;
      self.load_environment();
    });
    self.labels = $('<div/>');
    self.labels.css({
      paddingLeft: 10,
      paddingTop: 10,
      position: "absolute",
      display: "table",
      borderSpacing: "5px",
      zIndex: 100000
    });
    self.labels.appendTo('body');
  },

  destroy: function(){
    var self = this;
    $.each(self.players,function(id,player){
      player.destroy();
    });
    self.scene.destroy();
    self.root.empty();
  },

  load_environment: function(){
    var self = this;
    if (!self.load_environment_inprogress) {
      self.load_environment_inprogress = true;
      $.getJSON(self.environment_url,function(data){
        self.load_environment_inprogress = false;
        if (self.chunks_node) {
          self.chunks_node.destroy();
        }
        if (self.worldchunks_node) {
          self.worldchunks_node.destroy();
        }
        self.chunks_node = self.cam_node.addNode({
          type: "material",
          color: { r:0.5, g:0, b:0 },
          nodes: [self.chunks2node(data['Chunks'])]
        });
        self.worldchunks_node = self.cam_node.addNode({
          type: "material",
          color: { r:0, g:0.5, b:0 },
          nodes: [self.worldchunks2node(data['Worldchunks'])]
        });
      });
    }
  },

  on_event: function(event) {
    if (event.player) {
      console.log(event.player.name, event.EventName, event);
    } else {
      console.log(event.EventName, event);
    }
    var self = this;
    if (self.cam_node) {
      if (event.player) {
        self.on_playerevent(event);
      }
    }
  },

  on_playerevent: function(event) {
    var self = this;
    var player = event.player;
    var eventname = event.EventName;
    if ( eventname.match(/^PlayerEnterChunk$/)
      || eventname.match(/^PlayerTerrain/)
      || eventname.match(/^PlayerBlock/) ) {
      self.load_environment();
    }
    if (eventname.match(/^PlayerDisconnect$/)) {
      if (self.players[player.DBID]) {
        self.players[player.DBID].destroy();
        delete self.players[player.DBID];
      }
    } else {
      if (self.players[player.DBID]) {
        if (event.newChunk) {
          self.players[player.DBID].update(event.newChunk);
        } else {
          self.players[player.DBID].update(player.chunkPosition);
        }
      } else {
        self.players[player.DBID] = new RwMapServerPlayer(
          self.cam_node, self.labels, player, self.player_no
        );
        self.player_no = self.player_no + 1;
      }
      self.players[player.DBID].set_activity(event.EventName);
    }
  },

  chunks2node: function(chunks) {
    var cidx = {};
    var pos = [];
    var indices = [];
    var p = 0;

    $.each(chunks,function(i,c){
      var x = c[0];
      var y = c[1];
      var z = c[2];
      if (!cidx[x]) {
        cidx[x] = {};
      }
      if (!cidx[x][y]) {
        cidx[x][y] = {};
      }
      var cur = p++;
      cidx[x][y][z] = cur;
      pos.push(x);
      pos.push(y * 4);
      pos.push(z);
      if (z+1 in cidx[x][y]) {
        indices.push(cur,cidx[x][y][z+1]);
      }
      if (z-1 in cidx[x][y]) {
        indices.push(cur,cidx[x][y][z-1]);
      }
      if (cidx[x+1] && cidx[x+1][y]) {
        if (z in cidx[x+1][y]) {
          indices.push(cur,cidx[x+1][y][z]);
        }
      }
      if (cidx[x-1] && cidx[x-1][y]) {
        if (z in cidx[x-1][y]) {
          indices.push(cur,cidx[x-1][y][z]);
        }
      }
      if (cidx[x][y+1]) {
        if (z in cidx[x][y+1]) {
          indices.push(cur,cidx[x][y+1][z]);
        }
      }
      if (cidx[x][y-1]) {
        if (z in cidx[x][y-1]) {
          indices.push(cur,cidx[x][y-1][z]);
        }
      }
    });

    return {
      type: "geometry",
      primitive: "lines",
      positions: pos,
      indices: indices
    };

  },

  worldchunks2node: function(worldchunks) {

    var widx = {};
    var wpos = [];
    var windices = [];
    var wp = 0;

    $.each(worldchunks,function(i,c){
      var x = c[0];
      var y = 0;
      var z = c[1];
      if (!widx[x]) {
        widx[x] = {};
      }
      if (!widx[x][y]) {
        widx[x][y] = {};
      }
      var cur = wp++;
      widx[x][y][z] = cur;
      wpos.push(x);
      wpos.push(y);
      wpos.push(z);
      if (z+1 in widx[x][y]) {
        windices.push(cur,widx[x][y][z+1]);
      }
      if (z-1 in widx[x][y]) {
        windices.push(cur,widx[x][y][z-1]);
      }
      if (widx[x+1] && widx[x+1][y]) {
        if (z in widx[x+1][y]) {
          windices.push(cur,widx[x+1][y][z]);
        }
      }
      if (widx[x-1] && widx[x-1][y]) {
        if (z in widx[x-1][y]) {
          windices.push(cur,widx[x-1][y][z]);
        }
      }
    });

    return {
      type: "geometry",
      primitive: "lines",
      positions: wpos,
      indices: windices
    };

  }

});

var global_image_link; //globals :(. Should rethink this at some point.
var global_label;
var global_color;
var global_high_score;
var click_count = 0;
var previous_loc = [0,0];

function getImage(ctx){
	var jqxhr = $.get('/random_image', function () {
	        })
    .done(function(data) {
      var split_data = data.split('imagestart');
      var label = split_data[0];
      var split_label = label.split('!')
      //
      global_label = split_label[0];
      var im_text = split_label[1];
      global_high_score = split_label[2];
      //
      change_title(im_text);
      set_high_score(global_high_score);
      var accum_clicks = parseInt(split_label[3]);
      var clicks_to_go = parseInt(split_label[4]) - accum_clicks;
      update_chart(myChart,accum_clicks,clicks_to_go);
      //
      global_image_link = split_data[1];
      postImage(global_image_link,ctx);
      return;
    })
}

function postImage(image_link,ctx){
	var image = new Image();
    image.src = 'data:image/jpg;base64,' + image_link;
    try{
        ctx.drawImage(image,0,0);
    }catch(err){}
    
}

function change_title(text){
    global_color = getRandomColor();
    $('#image_label').html('<p style="color:' + global_color + ';">' + text + '</p>')
}

function getRandomColor() {
    var letters = '0123456789ABCDEF';
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

function hexToRgb(hex) {
    // Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
    var shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
    hex = hex.replace(shorthandRegex, function(m, r, g, b) {
        return r + r + g + g + b + b;
    });

    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16)
    } : null;
}

function  getMousePos(canvas, evt) {
  var rect = canvas.getBoundingClientRect(), // abs. size of element
      scaleX = canvas.width / rect.width,    // relationship bitmap vs. element for X
      scaleY = canvas.height / rect.height;  // relationship bitmap vs. element for Y

  return {
    x: (evt.clientX - rect.left) * scaleX,   // scale mouse coordinates after they have
    y: (evt.clientY - rect.top) * scaleY     // been adjusted to be relative to element
  }
}

function draw(e) {
    postImage(global_image_link,ctx)
    var pos = getMousePos(canvas, e);
    posx = pos.x;
    posy = pos.y;
    if (posx < 0){posx = 0;}
    if (posx > 256){posx = 256;}
    if (posy < 0){posy = 0;}
    if (posy > 256){posy = 256;}
    var rgb = hexToRgb(global_color)
    ctx.fillStyle = 'rgba(' + rgb['r'] + ',' +rgb['g'] + ',' + rgb['b'] + ',' + '0.4)';
    ctx.fillRect(posx-9, posy-9, 18, 18);
}

function sum(array) {
    var num = 0;
    for (var i = 0, l = array.length; i < l; i++) num += array[i];
    return num;
}

function mean(array) {
    return sum(array) / array.length;
}

function std(array) {
    var mu = mean(array);
    var sums = 0;
    for (var i = 0, l = array.length; i < l; i ++) sums+= Math.pow(array[i] - mu,2);
    return Math.sqrt(sums/l);
}

function compare_clicks(arr){
    if (std(arr) < 18){
        trigger_alert();
    }
}

function trigger_alert(){
    $('#spammer').html('<p style="color:Red">Are you really trying your hardest?</p>')
    setTimeout(function(){
        $('#spammer').html('')
    },3000)
}

function clicked(e) {
    var pos = getMousePos(canvas, e);
    posx = pos.x;
    posy = pos.y;
    if (posx < 0 || posx > 256 || posy < 0 || posy > 256){}
    else{
        window.removeEventListener('mousemove', draw, false);
        postImage(global_image_link,ctx);
        var rgb = hexToRgb(global_color)
        ctx.fillStyle = 'rgba(' + rgb['r'] + ',' +rgb['g'] + ',' + rgb['b'] + ',' + '1)';
        ctx.fillRect(posx-9, posy-9, 18, 18);
        window.removeEventListener('mousedown', clicked, false);
        count_clicks();
        upload_click_location([posx,posy]);
        previous_loc.push(posx,posy)
        compare_clicks(previous_loc);
        previous_loc = [posx,posy];
        setTimeout(function(){start_turn();},200);
    }
}

function upload_click_location(clicks){
    var data = {};
    data.clicks = clicks;
    data.image_id = global_label;
    data.score = click_count;
    $.ajax({
        type: 'POST',
        url: '/clicks',
        data: data,
        dataType: 'application/json',
        success: function(data) {
            console.log('uploaded click. update a status bar now');
        }
    });
}

function start_turn(){
    getImage(ctx);
    window.addEventListener('mousemove', draw, false);
    window.addEventListener('mousedown', clicked, false);
}

function count_clicks(){
    click_count+=1;
    $('#click_count').html('Your consecutive clicks: ' + click_count);
    if (click_count > global_high_score){
        global_high_score = click_count;
        set_high_score();
    }
}

function set_high_score(){
    $('#click_high_score').html('Today\'s high score: ' + global_high_score);
}

/////////
$(document).ready(function(){
    canvas = document.getElementById('myCanvas');
    ctx = canvas.getContext('2d');
    getImage(ctx);
    window.addEventListener('mousemove', draw, false);
    window.addEventListener('mousedown', clicked, false);
    start_turn()
})

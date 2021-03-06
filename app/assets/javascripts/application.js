// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//= require utf8_encode
//= require base64_encode

//= require helper

//= require plupload/moxie
//= require plupload/plupload.full.min
//= require plupload/i18n/zh_CN

//= require qrcode

//= require counter
//= require chronograph

$(document).ready(function(){
  var $loader = $("#loader");
  if($loader.size()){
    var chronograph = new Chronograph('chronograph', { size: 420 });

    var uploader = new plupload.Uploader({
      runtimes : 'html5', //,flash,silverlight,html4
      browse_button : 'loader', // you can pass in id...
      // drop_element: 'body',
      multi_selection: false,
      // container: document.getElementById('container'), // ... or DOM Element itself
      url : "http://upload.qiniu.com/",

      filters : {
        max_file_size : '500mb'
      },

      multipart_params: {
        token: $('#uptoken').val()
      }
    });

    uploader.bind("FilesAdded", function(up, files) {
      $('#chronograph .size').text(plupload.formatSize(files.slice(-1)[0].size));
      $('#chronograph .slogan').text('');
      $('#chronograph .intro').text('Your file is being uploaded, there');
      up.start();
      chronograph.run();
    });

    // Fires when a file is successfully uploaded.
    uploader.bind("FileUploaded", function(up, file, result) {
      var response = jQuery.parseJSON(result.response);
      $.post( "/file", { hash: response.hash, key: response.key }, function(url){
        // similar behavior as an HTTP redirect
        window.location.replace(url);
        // similar behavior as clicking on a link
        // window.location.href = url;
      });
    });

    uploader.bind("UploadProgress", function(up, file) {
      chronograph.second = file.percent / 100 * 360
      $('#chronograph .percent').text(file.percent + '%');
    });

    uploader.bind("Error", function(up, err) {
      alert("Error #" + err.code + ":\n" + err.message);
    });

    uploader.init();
  }


  var $downloader = $("#downloader");
  if($downloader.size()){
    new Counter('downloader', {
      size: 420,
      secondsColor : "#ffdc50",
      secondsGlow  : "#ffdc50",
      startDate   : $downloader.data('start'),
      endDate     : $downloader.data('deadline'),
      now         : (new Date()).getTime()/1000
    });

    new QRCode(document.getElementById("qrcode"), {
      text: $downloader.data('host'),
      width: 120,
      height: 120,
      colorDark : "#000000",
      colorLight : "#ccc",
      correctLevel : QRCode.CorrectLevel.M
    });
  }
});
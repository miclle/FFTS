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

//= require jquery.percentageloader-0.1

//= require counter
//= require chronograph

$(function() {


  // Upload page
  var $loader = $("#loader").percentageLoader({
    width: 256,
    height: 256,
    controllable : false,
    progress : 0
  });

  if($loader.size()){
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
      $loader.setValue(plupload.formatSize(files.slice(-1)[0].size));
      up.start();
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
      $loader.setProgress(file.percent / 100);
    });

    uploader.bind("Error", function(up, err) {
      alert("Error #" + err.code + ":\n" + err.message);
    });

    uploader.init();
  }

});
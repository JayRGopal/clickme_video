function readURL(input) {
  print("enter readURL')
  if (input.files && input.files[0]) {
      var reader = new FileReader();
    
      reader.onload = function (e) {
          $('#blah')
              .attr('src', e.target.result)
              .width(256)
              .height(256);
      };
    
      reader.readAsDataURL(input.files[0]);
  }
  }

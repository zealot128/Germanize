function retriever(){
    $('#word_name').each(function(){
    
        $(this).data('oldVal', $(this));
        $(this).bind("propertychange keyup input paste", function(event){
            if ($(this).data('oldVal') != $(this).val()) {
                $(this).data('oldVal', $(this).val());
                element = $('#retriever');
                word = $('#word_name').val()
                element.attr("href", element.attr("data-base") + "?word=" + encodeURI(word))
            }
        });
    })
    
}

function trim(s){ 
  return ( s || '' ).replace( /^\s+|\s+$/g, '' ); 
}

$(function(){

    $('a[rel*=facebox]').facebox();
    $('.solve').click(function(){
        $('.false').fadeIn('slow');
        $("a.correct").unbind("click");
        $("a.wrong").unbind("click");
		word = "<span class='highlight'>" + trim($('#word').text()) + "</span>";
		html = $('#examples').html().replace(/___+/g,word);
		$('#examples').html(html);
        return false;
    })
    $("a.correct").click(function() { return false; });
    $("a.wrong").click(function() { return false; });	
    
    $('#solve_form').submit(function() {
      $('.solve').click();
      return false;

    });
    if (document.location.pathname.match(/exercises\/\d+\/words\/\d+$/)) {
      $(document).bind('keypress', 'Alt+Shift+r', function() { 
          $('.correct').click() } 
          );  
      $(document).bind('keypress', 'Alt+Shift+f', function() { 
          $('.wrong').click() } 
          );  
      $(document).bind('keypress', 'Shift+n', function() { 
          $('#new_word_button').click() } 
      );  

      $('#answer').focus();
    }   

})

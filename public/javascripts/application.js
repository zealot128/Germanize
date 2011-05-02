function retriever(){
  /*
  $('#new_word,.edit_word').submit(function() {
      if (init ) {
        $('#retriever').click();
        init = false;
        return false;
      } else {
        return true;
      }
  });
  */

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

    $('#retriever').click(function() {
        $('#spinner').html("<img src='/images/spinner.gif'/>").show();
    });

    
}

function updateLevelCount() {
  $('.levels h3').each(function() { 
      level=$(this).find("a").attr("data-level"); 
      count= $("#container-"+level+" a").size(); 
      if (count>0) {
        html = "(" + count + ")"
        $(this).find(".count").html(html);
      }
  });
}

function qtipInit() {
  $('.hover-popup').qtip({
      content: 'Translating...', 
      style: {
        tip: true, // Create speech bubble tip at the set tooltip corner above
        name: 'cream'
      },
      api: {
        onRender: function() {
          var me = this;
          var target = $(me.elements.target);
          id = target.attr("data-id");
          link = window.location.pathname + "/" + id + "/popup";
          $.get(link, function(data) {
              me.updateContent(data);
              
          });
        }
      }
  });
}
/*
function ajaxifyLoginForm(){
    $('#facebox form').submit(function(){
        $("form").append("<img src='/facebox/loading.gif' id='loading-img'/>")
        var me = $(this); // need access to this in our callbacks
        
        $.ajax({
            type: 'POST',
            url: $(this).attr('action'),
            data: $(this).serialize(),
            dataType: 'html',
            success: function(data){
              window.location.reload();
            },
            error: function(xhr){
                if (xhr.status == '406') {
                    $('#errorExplanation').remove();
                    $('#loading-img').remove();
                              me.before('<div id="errorExplanation" class="errorExplanation">\
                      <h2>Fehler!</h2>\
                      <p>' + xhr.responseText + '</p>\
                      </div>');
                }
            }
        });
        return false;
    });
}
*/




function trim(s){ 
  return ( s || '' ).replace( /^\s+|\s+$/g, '' ); 
}

$(function(){

    $('a[rel*=facebox]').facebox();
    $('.solve').click(function(){
      $('#answer').hide();

      $('.false').fadeIn('slow');
      $("a.correct").unbind("click");
      $("a.wrong").unbind("click");
      $('.solve').unbind("click");
      word = "<span class='highlight'>" + trim($('#word').text()) + "</span>";
      html = $('#examples').html().replace(/___+/g,word);
      $('#examples').html(html);
      
      var answer = $('#answer').val();
      var word   = trim($('#word').text());
      if (answer.toLowerCase() == word.toLowerCase()) {
        $('#answer-notice').addClass("correct-notice")
        $('.solve').click(function() {
          $('a.correct').click();
        });
      } else {
        $('#answer-notice').addClass("wrong-notice")
        $('.solve').click(function() {
          $('a.wrong').click();
        });
      }
      $('#answer').fadeIn('slow');
      return false;
    })

    $("a.correct").click(function() { return false; });
    $("a.wrong").click(function() { return false; });	

    $('#solve_form').submit(function() {
      $('.solve').click();
      return false;

      });
    $(".progressBar").progressBar({ showText: false, barImage: '/images/progressbg_red.gif'});

    if (document.location.pathname.match(/exercises\/\d+\/words$/)) {
      qtipInit();
      updateLevelCount();
      $('.open_container').click(function() {
          level = $(this).attr("data-level");
          container = $('#container-' + level)
          if (container.html().length == 0) {
            // fetch
            link = window.location.pathname.replace("words","level") + "?level=" + level;
            container.hide();
            $.get(link, function(data) {
              container.html(data);
              qtipInit();
              container.slideDown(function() {
                updateLevelCount();
              });
            });
          } else {
            container.slideToggle(function() {
              updateLevelCount();
            });
          }
          return false;
      });

    }
/*
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

    }   
    */
      $('#answer').focus();


})

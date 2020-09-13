document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('td').forEach(function(td){
    td.addEventListener('mouseover', function(e){
      e.currentTarget.style.backgroudColor = '#eff';
  });

    td.addEventListener('mouseout',function(){
      e.currentTarget.style.backgroudColor = '';
    });
  });
});
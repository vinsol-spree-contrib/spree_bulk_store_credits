function UserSelectionManager(options){
  this.tableBodySelector = options.tableBodySelector;
  this.checkboxSelector = options.checkboxSelector;
}

UserSelectionManager.prototype.init = function(){
  $(this.tableBodySelector).on('change', this.checkboxSelector, this.hideRow());
};

UserSelectionManager.prototype.hideRow = function(){
  var _this = this;

  return function(){
    var changedCheckbox = this,
        $rowToMove = $($(this).parents('tr')[0]).fadeOut('slow', 'linear', _this.moveRow(changedCheckbox));
  };
};

UserSelectionManager.prototype.moveRow = function(changedCheckbox){
  var _this = this;

  return function(){
    $(this).remove();

    if($(changedCheckbox).is(':checked')){
      //moving row to the top of table
      $(_this.tableBodySelector).prepend($(this));
    }else{
      //moving row to the top of unselected rows
      var $latestSelectedCheckbox = $(_this.checkboxSelector + ':checked').last();
      if($latestSelectedCheckbox.length == 0){
        $(_this.tableBodySelector).prepend($(this));
      }else{
        $($latestSelectedCheckbox.parents('tr')[0]).after($(this));        
      }
    }
    $(this).fadeIn('slow', 'linear');
  };
};

$(function(){
  var userSelectionManagerArguments = { tableBodySelector: '#listing_users tbody',
                                       checkboxSelector: '[data-checkbox="user_select"]' },
      userSelectionManager = new UserSelectionManager(userSelectionManagerArguments);

  userSelectionManager.init();
});

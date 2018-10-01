function UserSelectorManager(options){
  this.tableBodySelector = options.tableBodySelector;
  this.checkboxSelector = options.checkboxSelector;
}

UserSelectorManager.prototype.init = function(){
  $(this.tableBodySelector).on('change', this.checkboxSelector, this.hideRow());
};

UserSelectorManager.prototype.hideRow = function(){
  var _this = this;

  return function(){
    var changedCheckbox = this,
        $rowToMove = $($(this).parents('tr')[0]).fadeOut('slow', 'linear', _this.moveRow(changedCheckbox));
  };
};

UserSelectorManager.prototype.moveRow = function(changedCheckbox){
  var _this = this;

  return function(){
    $(this).remove();

    if($(changedCheckbox).is(':checked')){
      //moving row to the top of table
      $(_this.tableBodySelector).prepend($(this));
    }else{
      //moving row to the top of unselected rows
      $($(_this.checkboxSelector + ':checked').last().parents('tr')[0]).after($(this));
    }
    $(this).fadeIn('slow', 'linear');
  };
};

$(function(){
  var userSelectorManagerArguments = { tableBodySelector: '#listing_users tbody',
                                       checkboxSelector: '[data-checkbox="user_select"]' },
      userSelectorManager = new UserSelectorManager(userSelectorManagerArguments);

  userSelectorManager.init();
});

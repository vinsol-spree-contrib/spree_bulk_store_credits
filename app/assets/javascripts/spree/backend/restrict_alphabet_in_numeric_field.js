function RestrictNumberField(input) {
  this.numberField = input.numberField;
}

RestrictNumberField.prototype.init = function() {
  this.numberField.keydown(function(e) {
    if ([69, 187, 188, 189, 190].includes(e.keyCode)) {
      e.preventDefault();
    }
  });
};

$(function() {
  var input = {
    numberField: $("input[name='credit_value']")
  },
    restrictNumberFieldManager = new RestrictNumberField(input);
  restrictNumberFieldManager.init();
});

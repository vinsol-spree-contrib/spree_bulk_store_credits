Deface::Override.new(
  virtual_path: 'spree/admin/shared/_content_header',
  name: 'add_import_button_on_user_index_page',
  insert_bottom: "div[data-hook='toolbar']",
  partial: 'spree/admin/users/import_button'
)

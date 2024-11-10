JsRoutes.setup do |c|
  c.module_type = "ESM"

  JsRoutes.generate!("routes.js")
end

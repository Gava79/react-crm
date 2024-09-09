module.exports = function override(config, env) {
    if (config.devServer) {
      config.devServer.setupMiddlewares = (middlewares, devServer) => {
        if (devServer) {
          // Your custom middleware code here
          devServer.app.use(/* your custom middleware */);
        }
        return middlewares;
      };
  
      // Remove deprecated options if they exist
      delete config.devServer.onBeforeSetupMiddleware;
      delete config.devServer.onAfterSetupMiddleware;
    }
    return config;
  };
  
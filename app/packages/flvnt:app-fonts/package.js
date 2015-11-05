
Package.describe({
  name    : 'flvnt:app-fonts',
  summary : 'flvnt-web public fonts',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client'];


  api.use([
    'coffeescript',
    'mquandalle:jade@0.4.2',
    'stylus',
    'underscore',
    'jquery'
  ], ['client', 'server']);

  api.use([
    'flvnt:env@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:lazyload@0.0.1',
    'flvnt:logger@0.0.1'
  ], ['client', 'server']);


  // BOOTSTRAP-GLYPHICON
  // -------------------
  api.add_files([
    'public/fonts/bootstrap/glyphicons-halflings-regular.eot',
    'public/fonts/bootstrap/glyphicons-halflings-regular.svg',
    'public/fonts/bootstrap/glyphicons-halflings-regular.ttf',
    'public/fonts/bootstrap/glyphicons-halflings-regular.woff',
    'public/fonts/bootstrap/glyphicons-halflings-regular.woff2'
  ], ['client'], { isAsset: true });


  // DIDOT
  // -----
  api.add_files([
    'public/fonts/didot/didot-B96/didot-B96.eot',
    'public/fonts/didot/didot-B96/didot-B96.otf',
    'public/fonts/didot/didot-B96/didot-B96.svg',
    'public/fonts/didot/didot-B96/didot-B96.ttf',
    'public/fonts/didot/didot-B96/didot-B96.woff',

    'public/fonts/didot/didot-B96-bold-ital/didot-B96-bold-ital.eot',
    'public/fonts/didot/didot-B96-bold-ital/didot-B96-bold-ital.otf',
    'public/fonts/didot/didot-B96-bold-ital/didot-B96-bold-ital.svg',
    'public/fonts/didot/didot-B96-bold-ital/didot-B96-bold-ital.ttf',
    'public/fonts/didot/didot-B96-bold-ital/didot-B96-bold-ital.woff',

    'public/fonts/didot/didot-L96/didot-L96.eot',
    'public/fonts/didot/didot-L96/didot-L96.otf',
    'public/fonts/didot/didot-L96/didot-L96.svg',
    'public/fonts/didot/didot-L96/didot-L96.ttf',
    'public/fonts/didot/didot-L96/didot-L96.woff',

    'public/fonts/didot/didot-L96-light-ital/didot-L96-light-ital.eot',
    'public/fonts/didot/didot-L96-light-ital/didot-L96-light-ital.otf',
    'public/fonts/didot/didot-L96-light-ital/didot-L96-light-ital.svg',
    'public/fonts/didot/didot-L96-light-ital/didot-L96-light-ital.ttf',
    'public/fonts/didot/didot-L96-light-ital/didot-L96-light-ital.woff',

    'public/fonts/didot/didot-M96-medium/didot-M96-medium.eot',
    'public/fonts/didot/didot-M96-medium/didot-M96-medium.otf',
    'public/fonts/didot/didot-M96-medium/didot-M96-medium.svg',
    'public/fonts/didot/didot-M96-medium/didot-M96-medium.ttf',
    'public/fonts/didot/didot-M96-medium/didot-M96-medium.woff',

    'public/fonts/didot/didot-M96-medium-ital/didot-M96-medium-ital.eot',
    'public/fonts/didot/didot-M96-medium-ital/didot-M96-medium-ital.otf',
    'public/fonts/didot/didot-M96-medium-ital/didot-M96-medium-ital.svg',
    'public/fonts/didot/didot-M96-medium-ital/didot-M96-medium-ital.ttf',
    'public/fonts/didot/didot-M96-medium-ital/didot-M96-medium-ital.woff'
  ], ['client'], { isAsset: true });


  // PROXIMANOVA
  // -----------
  api.add_files([
  ], ['client'], { isAsset: true });


  // HELVETICANUEUE
  // --------------
  api.add_files([
  ], ['client'], { isAsset: true });


  api.add_files([
    'lib/client/font-faces.styl'
  ], ['client']);


  // BOOTSTRAP GLYPHICON ASSETS
  // --------------------------
  // api.add_files([
  //   'public/images/glyphicons-halflings.png',
  //   'public/images/glyphicons-halflings-white.png'
  // ], where, { isAsset: true });


  api.export([
  ]);
});

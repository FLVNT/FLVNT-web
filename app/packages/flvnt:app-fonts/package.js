
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
    'jquery',
    'flvnt:env@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:lazyload@0.0.1',
    'flvnt:logger@0.0.1'
  ], where);


  // BOOTSTRAP-GLYPHICON
  // -------------------
  api.add_files([
    'public/fonts/bootstrap/glyphicons-halflings-regular.eot',
    'public/fonts/bootstrap/glyphicons-halflings-regular.svg',
    'public/fonts/bootstrap/glyphicons-halflings-regular.ttf',
    'public/fonts/bootstrap/glyphicons-halflings-regular.woff',
    'public/fonts/bootstrap/glyphicons-halflings-regular.woff2'
  ], where, { isAsset: true });


  // DIDOT
  // -----
  api.add_files([
    'public/fonts/didot/didot-B96-bold/didot-B96-bold.eot',
    'public/fonts/didot/didot-B96-bold/didot-B96-bold.otf',
    'public/fonts/didot/didot-B96-bold/didot-B96-bold.svb',
    'public/fonts/didot/didot-B96-bold/didot-B96-bold.ttf',
    'public/fonts/didot/didot-B96-bold/didot-B96-bold.woff',

    'public/fonts/didot/didot-B96-bold-ital/didot-B96-bold-ital.eot',
    'public/fonts/didot/didot-B96-bold-ital/didot-B96-bold-ital.otf',
    'public/fonts/didot/didot-B96-bold-ital/didot-B96-bold-ital.svb',
    'public/fonts/didot/didot-B96-bold-ital/didot-B96-bold-ital.ttf',
    'public/fonts/didot/didot-B96-bold-ital/didot-B96-bold-ital.woff',

    'public/fonts/didot/didot-L96-light/didot-L96-light.eot',
    'public/fonts/didot/didot-L96-light/didot-L96-light.otf',
    'public/fonts/didot/didot-L96-light/didot-L96-light.svb',
    'public/fonts/didot/didot-L96-light/didot-L96-light.ttf',
    'public/fonts/didot/didot-L96-light/didot-L96-light.woff',

    'public/fonts/didot/didot-L96-light-ital/didot-L96-light-ital.eot',
    'public/fonts/didot/didot-L96-light-ital/didot-L96-light-ital.otf',
    'public/fonts/didot/didot-L96-light-ital/didot-L96-light-ital.svb',
    'public/fonts/didot/didot-L96-light-ital/didot-L96-light-ital.ttf',
    'public/fonts/didot/didot-L96-light-ital/didot-L96-light-ital.woff',

    'public/fonts/didot/didot-M96-medium/didot-M96-medium.eot',
    'public/fonts/didot/didot-M96-medium/didot-M96-medium.otf',
    'public/fonts/didot/didot-M96-medium/didot-M96-medium.svb',
    'public/fonts/didot/didot-M96-medium/didot-M96-medium.ttf',
    'public/fonts/didot/didot-M96-medium/didot-M96-medium.woff',

    'public/fonts/didot/didot-M96-medium-ital/didot-M96-medium-ital.eot',
    'public/fonts/didot/didot-M96-medium-ital/didot-M96-medium-ital.otf',
    'public/fonts/didot/didot-M96-medium-ital/didot-M96-medium-ital.svb',
    'public/fonts/didot/didot-M96-medium-ital/didot-M96-medium-ital.ttf',
    'public/fonts/didot/didot-M96-medium-ital/didot-M96-medium-ital.woff'
  ], where, { isAsset: true });


  // PROXIMANOVA
  // -----------
  api.add_files([
  ])


  // HELVETICANUEUE
  // --------------
  api.add_files([
  ])


  // api.add_files([
  //   'public/images/glyphicons-halflings.png',
  //   'public/images/glyphicons-halflings-white.png'
  // ], where, { isAsset: true });

});

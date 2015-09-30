
Package.describe({
  name    : 'flvnt:bootstrap',
  summary : 'flvnt-web custom bootstrap (v3.0.3) build packaged for meteor.js',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client'];

  api.use([
    'coffeescript',
    'jquery',
    'underscore'
  ], where);


  api.add_files([

    // BOOTSTRAP CSS CORE
    // ------------------
    'lib/client/styles/bootstrap.css',
    'lib/client/styles/img-styles.css',
    'lib/client/styles/text-styles.css',
    'lib/client/styles/list-styles.css',


    // BOOTSTRAP CSS COMPONENTS
    // ------------------------

    // 'lib/client/styles/definition-list.css',
    // 'lib/client/styles/blockquote.css',
    'lib/client/styles/grid.css',
    'lib/client/styles/form-control.css',
    'lib/client/styles/form-control-themes.css',
    'lib/client/styles/btn.css',

    // 'lib/client/styles/btn-default.css',
    // 'lib/client/styles/btn-primary.css',
    // 'lib/client/styles/btn-warning.css',
    // 'lib/client/styles/btn-danger.css',
    // 'lib/client/styles/btn-success.css',
    // 'lib/client/styles/btn-info.css',
    // 'lib/client/styles/btn-link.css',
    // 'lib/client/styles/btn-sizes.css',

    'lib/client/styles/opacity-effects.css',
    'lib/client/styles/glyphicon.css',

    // 'lib/client/styles/dropdown.css',
    // 'lib/client/styles/btn-group.css',
    // 'lib/client/styles/input-group.css',

    'lib/client/styles/nav.css',
    // 'lib/client/styles/nav-pill.css',
    // 'lib/client/styles/nav-stacked.css',
    // 'lib/client/styles/nav-justified.css',
    // 'lib/client/styles/nav-tabs.css',

    'lib/client/styles/navbar.css',
    // 'lib/client/styles/navbar-header.css',
    // 'lib/client/styles/navbar-collapse.css',
    'lib/client/styles/navbar-fixed.css',
    // 'lib/client/styles/navbar-toggle.css',
    // 'lib/client/styles/navbar-form.css',
    'lib/client/styles/navbar-nav.css',
    'lib/client/styles/navbar-btn.css',
    'lib/client/styles/navbar-text.css',

    // 'lib/client/styles/navbar-style-default.css',
    // 'lib/client/styles/navbar-style-inverse.css',

    // 'lib/client/styles/pager.css',
    'lib/client/styles/label.css',
    'lib/client/styles/label-themes.css',
    // 'lib/client/styles/badge.css',
    // 'lib/client/styles/jumbotron.css',
    // 'lib/client/styles/thumbnail.css',
    'lib/client/styles/alert.css',
    'lib/client/styles/alert-themes.css',
    // 'lib/client/styles/media-list.css',
    // 'lib/client/styles/list-group.css',
    // 'lib/client/styles/panel.css',
    'lib/client/styles/modal.css',
    'lib/client/styles/tooltip.css',
    'lib/client/styles/popover.css',
    // 'lib/client/styles/carousel.css',


    // BOOTSTRAP-CORE
    // --------------
    'lib/client/styles/bootstrap-post.css',


    // JAVASCRIPT COMPONENTS
    // ---------------------

    'lib/client/scripts/alert.js',
    // 'lib/client/scripts/button.js',
    // 'lib/client/scripts/carousel.js',
    'lib/client/scripts/collapse.js',
    'lib/client/scripts/dropdown.js',
    'lib/client/scripts/modal.js',
    'lib/client/scripts/tooltip.js',
    'lib/client/scripts/popover.js',
    // 'lib/client/scripts/scrollspy.js',
    // 'lib/client/scripts/tab.js',
    'lib/client/scripts/transition.js',


    'public/images/bootstrap/glyphicons-halflings.png',
    'public/images/bootstrap/glyphicons-halflings-white.png',


    // CUSTOM PROJECT OVERRIDES
    // ------------------------
    'lib/client/styles/bootstrap-meteor-overrides.css',


  ], where);


  api.add_files([
    // FONTS
    // ---------------------
    'public/fonts/bootstrap/glyphicons-halflings-regular.eot',
    'public/fonts/bootstrap/glyphicons-halflings-regular.svg',
    'public/fonts/bootstrap/glyphicons-halflings-regular.ttf',
    'public/fonts/bootstrap/glyphicons-halflings-regular.woff',
    'public/fonts/bootstrap/glyphicons-halflings-regular.woff2'
  ], where, {isAsset: true});

});

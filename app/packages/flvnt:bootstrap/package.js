
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
    'lib/client/styles/list/list-styles.css',


    // BOOTSTRAP CSS COMPONENTS
    // ------------------------

    // 'lib/client/styles/definition-list.css',
    // 'lib/client/styles/blockquote/blockquote.css',


    'lib/client/styles/grid/grid.css',
    'lib/client/styles/grid/grid-container.css',
    'lib/client/styles/grid/grid-row.css',
    'lib/client/styles/grid/grid-col.css',
    'lib/client/styles/grid/grid-col-xs.css',
    // 'lib/client/styles/grid/grid-col-xs-pull.css',
    // 'lib/client/styles/grid/grid-col-xs-push.css',
    // 'lib/client/styles/grid/grid-col-xs-offset.css',
    'lib/client/styles/grid/grid-768.css',
    'lib/client/styles/grid/grid-992.css',
    'lib/client/styles/grid/grid-1200.css',



    'lib/client/styles/form-control/form-control.css',
    // 'lib/client/styles/form-control/form-control-themes-warning.css',
    // 'lib/client/styles/form-control/form-control-themes-success.css',
    // 'lib/client/styles/form-control/form-control-themes-error.css',
    // 'lib/client/styles/form-control/form-control-sizes.css',
    'lib/client/styles/form-control/form-control-themes.css',
    // 'lib/client/styles/form-control/form-control-horizontal.css',



    'lib/client/styles/btn/btn.css',
    // 'lib/client/styles/btn/btn-link.css',
    // 'lib/client/styles/btn/btn-sizes.css',
    // 'lib/client/styles/btn/themes/btn-default.css',
    // 'lib/client/styles/btn/themes/btn-danger.css',
    // 'lib/client/styles/btn/themes/btn-primary.css',
    // 'lib/client/styles/btn/themes/btn-success.css',
    // 'lib/client/styles/btn/themes/btn-warning.css',
    // 'lib/client/styles/btn/themes/btn-info.css',


    'lib/client/styles/opacity-effects/fade.css',
    // 'lib/client/styles/opacity-effects/collapse.css',


    'lib/client/styles/glyphicon/glyphicon.css',


    // 'lib/client/styles/dropdown.css',
    // 'lib/client/styles/btn-group.css',
    // 'lib/client/styles/input-group.css',



    'lib/client/styles/nav/nav.css',
    // 'lib/client/styles/nav/nav-pill.css',
    // 'lib/client/styles/nav/nav-stacked.css',
    // 'lib/client/styles/nav/nav-justified.css',


    // 'lib/client/styles/nav-tabs/nav-tabs.css',
    // // 'lib/client/styles/nav-tabs/nav-tabs-justified.css',
    // 'lib/client/styles/nav-tabs/tab-content.css',
    // 'lib/client/styles/nav-tabs/tab-dropdown-menu.css',


    'lib/client/styles/navbar/navbar.css',
    // 'lib/client/styles/navbar/navbar-header.css',
    // 'lib/client/styles/navbar/navbar-collapse.css',
    'lib/client/styles/navbar/navbar-fixed.css',
    // 'lib/client/styles/navbar/navbar-toggle.css',
    // 'lib/client/styles/navbar/navbar-form.css',
    'lib/client/styles/navbar/navbar-nav.css',
    // 'lib/client/styles/navbar/navbar-btn.css',
    // 'lib/client/styles/navbar/navbar-text.css',
    // 'lib/client/styles/navbar/themes/navbar-default.css',
    // 'lib/client/styles/navbar/themes/navbar-inverse.css',


    // 'lib/client/styles/pager/pagination.css',
    // 'lib/client/styles/pager.css',


    'lib/client/styles/form-control/label/label.css',
    // 'lib/client/styles/form-control/label/label-themes.css',


    // 'lib/client/styles/badge/badge.css',
    // 'lib/client/styles/jumbotron/jumbotron.css',
    // 'lib/client/styles/thumbnail/thumbnail.css',


    // 'lib/client/styles/alert/alert.css',
    // 'lib/client/styles/alert/alert-themes.css',


    // 'lib/client/styles/list/media-list.css',
    // 'lib/client/styles/list/list-group.css',
    // 'lib/client/styles/panel/panel.css',


    'lib/client/styles/modal/modal-close.css',
    'lib/client/styles/modal/modal-fade.css',
    'lib/client/styles/modal/modal-backdrop.css',
    'lib/client/styles/modal/modal.css',
    'lib/client/styles/modal/modal-header.css',
    'lib/client/styles/modal/modal-content.css',
    'lib/client/styles/modal/modal-footer.css',


    'lib/client/styles/tooltip/tooltip.css',
    'lib/client/styles/tooltip/tooltip-position.css',
    'lib/client/styles/tooltip/tooltip-arrow.css',


    'lib/client/styles/popover/popover.css',
    'lib/client/styles/popover/popover-position.css',
    'lib/client/styles/popover/popover-arrow.css',


    // 'lib/client/styles/carousel/carousel.css',

    'lib/client/styles/clearfix/clearfix.css',
    'lib/client/styles/visible-display/visible-display.css',
    // 'lib/client/styles/visible-display/print.css',


    // BOOTSTRAP-CORE
    // --------------
    'lib/client/styles/bootstrap-post.css',


    'lib/client/styles/meteor-overrides/boostrap.css'
  ], where);


  // JAVASCRIPT COMPONENTS
  // ---------------------
  api.add_files([
    // 'lib/client/scripts/alert.js',
    // 'lib/client/scripts/button.js',
    // 'lib/client/scripts/carousel.js',
    'lib/client/scripts/collapse.js',
    'lib/client/scripts/dropdown.js',
    'lib/client/scripts/modal.js',
    'lib/client/scripts/tooltip.js',
    'lib/client/scripts/popover.js',
    // 'lib/client/scripts/scrollspy.js',
    // 'lib/client/scripts/tab.js',
    'lib/client/scripts/transition.js'
  ], where);


  api.add_files([
    'public/images/bootstrap/glyphicons-halflings.png',
    'public/images/bootstrap/glyphicons-halflings-white.png'
  ], where, { isAsset: true });


  // FONTS
  // ---------------------
  api.add_files([
    'public/fonts/bootstrap/glyphicons-halflings-regular.eot',
    'public/fonts/bootstrap/glyphicons-halflings-regular.svg',
    'public/fonts/bootstrap/glyphicons-halflings-regular.ttf',
    'public/fonts/bootstrap/glyphicons-halflings-regular.woff',
    'public/fonts/bootstrap/glyphicons-halflings-regular.woff2'
  ], where, {isAsset: true});

});

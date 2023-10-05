let mix = require('laravel-mix');
let execSync = require('child_process').execSync;

mix.js('Modules/Galleries/Resources/assets/admin/js/main.js', 'Modules/Galleries/Assets/admin/js/galleries.js')
    .sass('Modules/Galleries/Resources/assets/admin/sass/main.scss', 'Modules/Galleries/Assets/admin/css/galleries.css')
    .then(() => {
        execSync('npm run rtlcss Modules/Galleries/Assets/admin/css/galleries.css Modules/Galleries/Assets/admin/css/galleries.rtl.css');
    });

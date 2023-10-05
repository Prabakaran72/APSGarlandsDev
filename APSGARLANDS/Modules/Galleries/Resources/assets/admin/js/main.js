import ImagePicker from './ImagePicker';
// import GalleriesPicker from './GalleriesPicker';
import Uploader from './Uploader';

window.GalleriesPicker = GalleriesPicker;

if ($('.image-picker').length !== 0) {
    new ImagePicker();
}

if ($('.dropzone').length !== 0) {
    new Uploader();
}

export default {
    methods: {
        productUrl(product) {
            return route('products.show', product.slug);
        },

        hasBaseImage(product) {
            return product.base_image.length !== 0;
        },

        baseImage(product) {
            if (this.hasBaseImage(product)) {
                return product.base_image.path;
            }

            return `${window.FleetCart.baseUrl}/themes/storefront/public/images/image-placeholder.png`;
        },
        productPreparingDay(product) {
          
            if (product.is_preorder_status === 1) { // Use strict equality (===) for integer comparison
                return product.prepare_days;
            } else {
                return 0;
            }
        },
        isAfternoon() {
            
            const now = new Date();
            const hours = now.getHours();
            const minutes = now.getMinutes();
        
            // Check if it's after 1:00 PM (13:00)
            if (hours > 13 || (hours === 13 && minutes >= 0)) {
                return 1; // Afternoon
            } else {
                return 0; // Morning
            }
        }
    },
};

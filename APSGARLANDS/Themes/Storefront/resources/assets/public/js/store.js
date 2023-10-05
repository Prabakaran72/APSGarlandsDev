import Vue from "vue";
import { isEmpty } from "./functions";

export default {
    state: Vue.observable({
        cart: FleetCart.cart,
        wishlist: FleetCart.wishlist,
        compareList: FleetCart.compareList,
    }),

    cartIsEmpty() {
        return isEmpty(this.state.cart.items);
    },

    updateCart(cart) {
        this.state.cart = cart;
    },

    removeCartItem(cartItem) {
        Vue.delete(this.state.cart.items, cartItem.id);
    },

    clearCart() {
        this.state.cart.items = {};
    },

    hasShippingMethod() {
        return (
            Object.keys(this.state.cart.availableShippingMethods).length !== 0
        );
    },

    wishlistCount() {
        return this.state.wishlist.length;
    },

    inWishlist(productId) {
        return this.state.wishlist.includes(productId);
    },

    syncWishlist(productId) {
        if (this.inWishlist(productId)) {
            this.removeFromWishlist(productId);
        } else {
            this.addToWishlist(productId);
        }
    },

    addToWishlist(productId) {
        if (FleetCart.loggedIn) {
            this.state.wishlist.push(productId);
        } else {
            return (window.location.href = route("login"));
        }

        $.ajax({
            method: "POST",
            url: route("wishlist.store"),
            data: { productId },
        });
    },


    // removeMultiDatasFromWishlist(productsDataId, getReason) {
                
    //     console.log('productsDataId',productsDataId.length);        
    //     console.log('getReason',getReason);        
       

    //     this.state.wishlist.splice(this.state.wishlist.indexOf(productsDataId.length), 1);

    //     this.state.wishlist.length - productsDataId.length;

    //     $.ajax({
    //         method: "DELETE",
    //         url: route('wishlist.products.delete',{ productsDataId, getReason }),
    //     })
    // },


    removeMultiDatasFromWishlist(productsDataId, getReason) {    
                                                           
        const newWishlist = this.state.wishlist.filter(item => !productsDataId.includes(item));        
        this.state.wishlist = newWishlist;
        
        this.wishlistCount();        
      
        // Make the AJAX request to delete the items on the server
        $.ajax({
          method: "DELETE",
          url: route('wishlist.products.delete', { productsDataId, getReason }),
        });                       
      },

      

    removeFromWishlist(productId, data) {
        var proData = data.reason;       
        this.state.wishlist.splice(this.state.wishlist.indexOf(productId), 1);

        $.ajax({
            method: "DELETE",
            url: route("wishlist.destroy", { productId, proData }),
        });
    },

    inCompareList(productId) {
        return this.state.compareList.includes(productId);
    },

    syncCompareList(productId) {
        if (this.inCompareList(productId)) {
            this.removeFromCompareList(productId);
        } else {
            this.addToCompareList(productId);
        }
    },

    addToCompareList(productId) {
        this.state.compareList.push(productId);

        $.ajax({
            method: "POST",
            url: route("compare.store"),
            data: { productId },
        });
    },

    removeFromCompareList(productId) {
        this.state.compareList.splice(
            this.state.compareList.indexOf(productId),
            1
        );

        $.ajax({
            method: "DELETE",
            url: route("compare.destroy", { productId }),
        });
    },
};

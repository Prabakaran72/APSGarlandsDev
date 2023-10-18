<template>
    <div class="container">
        <div id="success" class="mb-3">{{ successMessage }}</div>
        <a style="cursor: pointer" @click.prevent="likeBlog">
            <i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
             ({{ alllikes }}) </a>
            <a style="cursor: pointer" @click.prevent="dislikeBlog">
            <i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
             ({{ alldislikes }}) </a>
    </div>
</template>
<script>
    export default {
        props: ['blog','alllikes','alldislikes'],
        data() {
            return {
                alllikes: this.alllikes ,
                alldislikes: this.alldislikes ,
                successMessage:'',

            };
        },
        methods: {
            likeBlog() {
                $.ajax({
                   url: route('account.blogs.handleLike', { id: this.blog }),
                     type: "POST",
                    data: { blog: this.blog },
                    dataType: 'json',
                    success: (res) => {
                         this.alllikes = res.likeCount;
                         this.alldislikes = res.dislikeCount;
                         this.successMessage=res.message
                        $('#success').html(this.successMessage);
                         setTimeout(() => {
                            this.successMessage = '';
                        }, 3000);
                    },
                    error: (jqXHR, textStatus, errorThrown) => {
                        console.log("AJAX Error:", textStatus, errorThrown);
                    }
                });
            },    
         dislikeBlog() {
                $.ajax({
                     url: route('account.blogs.handleDislike', { id: this.blog }),
                    type: "POST",
                    data: { blog: this.blog },
                    dataType: 'json',
                    success: (res) => {
                        this.alldislikes = res.dislikeCount;
                         this.alllikes = res.likeCount;
                         this.successMessage=res.message
                        $('#success').html(this.successMessage);
                         setTimeout(() => {
                            this.successMessage = '';
                        }, 3000);
                    },
                    error: (jqXHR, textStatus, errorThrown) => {
                        console.log("AJAX Error:", textStatus, errorThrown);
                    }
                });
            },
        },
        
    };
</script>

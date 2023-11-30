@extends('public.layout')

@section('title', trans('storefront::account.view_testimonial.view_testimonial'))

@section('breadcrumb')
    <li><a href="{{ route('account.dashboard.index') }}">{{ trans('storefront::account.pages.my_account') }}</a></li>
    <li><a href="{{ route('account.testimonials.index') }}">{{ trans('storefront::account.pages.my_testimonials') }}</a></li>
    <li class="active">{{ trans('storefront::account.testimonials.view_testimonial') }}</li>

@endsection

@section('content')
    <section class="order-details-wrap">
        <div class="container">
            <div class="order-details-top">
                <h3 class="section-title">{{ trans('storefront::account.view_testimonial.view_testimonial') }}
                </h3>

                <form method="POST" action="{{ route('account.testimonials.update', ['id' => $testimonials->id]) }}">
                    @csrf
                    @method('PUT')
                    <table>
                        <td>
                            <tr>
                                <textarea name="comment" id="comment" cols="30" rows="10">{{ $testimonials->comment }}</textarea>
                            </tr>
                            <br>
                            <tr>
                                <button type="submit" class="btn btn-primary">Update</button>
                            </tr>
                        </td>
                    </table>
                </form>
            </div>
    </section>
@endsection

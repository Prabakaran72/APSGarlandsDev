@extends('public.account.layout')

@section('title', trans('storefront::account.pages.my_testimonials'))

@section('account_breadcrumb')
    <li class="active">{{ trans('storefront::account.pages.my_testimonials') }}</li>
@endsection


@section('panel')
    <div class="panel">
        <div class="panel-header">
            <h4>{{ trans('storefront::account.pages.my_testimonials') }}</h4>
        </div>

        <div class="panel-body">
            @if ($testimonials->isEmpty())
                <div class="empty-message">
                    <h3>{{ trans('storefront::account.testimonials.no_testimonials') }}</h3>
                </div>
            @else
                <div id="testimonial_div" class="table-responsive">
                    <table class="table table-borderless my-testimonials-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Comment</th>
                                {{-- <th>{{ trans('storefront::account.status') }}</th> --}}
                                <th>{{ trans('storefront::account.date') }}</th>
                            </tr>
                        </thead>

                        <tbody>
                            @foreach ($testimonials as $testimonial)
                                <tr>

                                    <td>
                                        {{ $testimonial->user_name}}
                                    </td>

                                    <td>
                                        {{ $testimonial->comment}}
                                    </td>

                                    {{-- <td>
                                        {{ $testimonial->is_approved}}
                                    </td> --}}

                                    <td>
                                        {{ $testimonial->created_at->toFormattedDateString() }}
                                    </td>

                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            @endif
        </div>

        <div class="panel-footer">
            {!! $testimonials->links() !!}
        </div>
    </div>
@endsection

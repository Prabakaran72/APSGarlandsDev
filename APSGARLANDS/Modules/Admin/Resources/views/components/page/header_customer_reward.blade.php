@section('title')
    @isset($subtitle)
        {{ "{$subtitle} - {$title}" }}
    @else
        {{ $title }}
    @endisset
@endsection


@section('content_header')
    @if (!empty($customername))
        <h3>{{ $title . ' (' . $customername . ')' }}
    @else 
        <h3>{{ $title }}
    @endif
    </h3>

    <ol class="breadcrumb">
        <li><a href="{{ route('admin.dashboard.index') }}">{{ trans('admin::dashboard.dashboard') }}</a></li>

        {{ $slot }}
    </ol>


@endsection

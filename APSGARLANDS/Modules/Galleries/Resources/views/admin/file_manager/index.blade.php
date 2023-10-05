<!DOCTYPE html>
<html lang="{{ locale() }}">
<head>
    <meta charset="UTF-8">

    <title>{{ trans('galleries::galleries.file_manager.title') }}</title>

    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <link href="https://fonts.googleapis.com/css?family=Open+Sans:600|Roboto" rel="stylesheet">

    @foreach ($assets->allCss() as $css)
        <link galleries="all" type="text/css" rel="stylesheet" href="{{ v($css) }}">
    @endforeach

    @include('admin::partials.globals')
</head>

<body class="file-manager">
    <div class="container">
        @include('galleries::admin.galleries.partials.uploader')

        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    @include('galleries::admin.galleries.partials.table')
                </div>
            </div>
        </div>
    </div>

    <div id="notification-toast"></div>

    @include('admin::partials.confirmation_modal')

    @foreach ($assets->allJs() as $js)
        <script src="{{ v($js) }}"></script>
    @endforeach

    <script>
        DataTable.setRoutes('.file-manager .table', {
            index: {
                name: 'admin.galleries.index',
                params: { type: '{{ $type }}' }
            },
            destroy: 'admin.galleries.destroy',
        });

        new DataTable('.file-manager .table', {
            columns: [
                { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                { data: 'id', width: '5%' },
                { data: 'thumbnail', orderable: false, searchable: false, width: '10%' },
                { data: 'filename', name: 'filename' },
                { data: 'created', name: 'created_at' },
                { data: 'action', orderable: false, searchable: false },
            ],
        });
    </script>
</body>
</html>

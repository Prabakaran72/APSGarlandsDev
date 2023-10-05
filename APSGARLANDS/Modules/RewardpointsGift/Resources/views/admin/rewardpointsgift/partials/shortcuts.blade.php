@push('shortcuts')
    <dl class="dl-horizontal">
        <dt><code>b</code></dt>
        <dd>{{ trans('admin::admin.shortcuts.back_to_index', ['name' => trans('tag::tags.tag')]) }}</dd>
    </dl>
@endpush

@push('scripts')
    <script>
        keypressAction([
            { key: 'b', route: "{{ route('admin.tags.index') }}" }
        ]);

        // $("#reward_point_remarks").on('input', function () {
        //     var maxLength = 100;
        //     if ($(this).val().length > maxLength) {
        //         $(this).val($(this).val().substring(0, maxLength)); // Truncate the text
        //     }
        // });
        // $('#rewardpointsupdate').on('click', function(){
        //     let reward_point_remarks = $('#reward_point_remarks').val();
        //     let reward_point_value = $('#reward_point_value').val();
     
        //     if (reward_point_value && reward_point_remarks){

        //     }else if(reward_point_remarks){
              

        //     }
        //     else if(reward_point_value)
        //     {

        //     }

        //     console.log("reward_point_value", reward_point_value)
        //     console.log("reward_point_remarks", reward_point_remarks)
        // })
    </script>
@endpush

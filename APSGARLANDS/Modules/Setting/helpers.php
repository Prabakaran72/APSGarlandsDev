<?php

if (! function_exists('setting')) {
    /**
     * Get / set the specified setting value.
     *
     * If an array is passed, we'll assume you want to set settings.
     *
     * @param string|array $key
     * @param mixed $default
     * @return mixed|\Modules\Setting\Repository
     */
    function setting($key = null, $default = null)
    {
        // if($key == "recurring_order_enabled")
        // {
        //     dd(app('setting')->get($key, $default));
        // }
    
        if (is_null($key)) {
            return app('setting');
        }

        if (is_array($key)) {
            return app('setting')->set($key);
        }

        try {
            return app('setting')->get($key, $default);
        } catch (PDOException $e) {
            dd($e);
            return $default;
        }
    }
}

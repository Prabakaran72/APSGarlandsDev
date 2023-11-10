/*
 * ATTENTION: An "eval-source-map" devtool has been used.
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file with attached SourceMaps in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./Modules/Order/Resources/assets/admin/js/main.js":
/*!*********************************************************!*\
  !*** ./Modules/Order/Resources/assets/admin/js/main.js ***!
  \*********************************************************/
/***/ (() => {

eval("$('#order-status').change(function (e) {\n  $.ajax({\n    type: 'PUT',\n    url: route('admin.orders.status.update', e.currentTarget.dataset.id),\n    data: {\n      status: e.currentTarget.value\n    },\n    success: function (_success) {\n      function success(_x) {\n        return _success.apply(this, arguments);\n      }\n      success.toString = function () {\n        return _success.toString();\n      };\n      return success;\n    }(function (message) {\n      success(message);\n    }),\n    error: function (_error) {\n      function error(_x2) {\n        return _error.apply(this, arguments);\n      }\n      error.toString = function () {\n        return _error.toString();\n      };\n      return error;\n    }(function (xhr) {\n      error(xhr.responseJSON.message);\n    })\n  });\n});//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiLi9Nb2R1bGVzL09yZGVyL1Jlc291cmNlcy9hc3NldHMvYWRtaW4vanMvbWFpbi5qcyIsIm5hbWVzIjpbIiQiLCJjaGFuZ2UiLCJlIiwiYWpheCIsInR5cGUiLCJ1cmwiLCJyb3V0ZSIsImN1cnJlbnRUYXJnZXQiLCJkYXRhc2V0IiwiaWQiLCJkYXRhIiwic3RhdHVzIiwidmFsdWUiLCJzdWNjZXNzIiwiX3N1Y2Nlc3MiLCJfeCIsImFwcGx5IiwiYXJndW1lbnRzIiwidG9TdHJpbmciLCJtZXNzYWdlIiwiZXJyb3IiLCJfZXJyb3IiLCJfeDIiLCJ4aHIiLCJyZXNwb25zZUpTT04iXSwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsid2VicGFjazovL2ZsZWV0Y2FydC8uL01vZHVsZXMvT3JkZXIvUmVzb3VyY2VzL2Fzc2V0cy9hZG1pbi9qcy9tYWluLmpzP2UzZjAiXSwic291cmNlc0NvbnRlbnQiOlsiJCgnI29yZGVyLXN0YXR1cycpLmNoYW5nZSgoZSkgPT4ge1xyXG4gICAgJC5hamF4KHtcclxuICAgICAgICB0eXBlOiAnUFVUJyxcclxuICAgICAgICB1cmw6IHJvdXRlKCdhZG1pbi5vcmRlcnMuc3RhdHVzLnVwZGF0ZScsIGUuY3VycmVudFRhcmdldC5kYXRhc2V0LmlkKSxcclxuICAgICAgICBkYXRhOiB7IHN0YXR1czogZS5jdXJyZW50VGFyZ2V0LnZhbHVlIH0sXHJcbiAgICAgICAgc3VjY2VzczogKG1lc3NhZ2UpID0+IHtcclxuICAgICAgICAgICAgc3VjY2VzcyhtZXNzYWdlKTtcclxuICAgICAgICB9LFxyXG4gICAgICAgIGVycm9yOiAoeGhyKSA9PiB7XHJcbiAgICAgICAgICAgIGVycm9yKHhoci5yZXNwb25zZUpTT04ubWVzc2FnZSk7XHJcbiAgICAgICAgfSxcclxuICAgIH0pO1xyXG59KTtcclxuIl0sIm1hcHBpbmdzIjoiQUFBQUEsQ0FBQyxDQUFDLGVBQWUsQ0FBQyxDQUFDQyxNQUFNLENBQUMsVUFBQ0MsQ0FBQyxFQUFLO0VBQzdCRixDQUFDLENBQUNHLElBQUksQ0FBQztJQUNIQyxJQUFJLEVBQUUsS0FBSztJQUNYQyxHQUFHLEVBQUVDLEtBQUssQ0FBQyw0QkFBNEIsRUFBRUosQ0FBQyxDQUFDSyxhQUFhLENBQUNDLE9BQU8sQ0FBQ0MsRUFBRSxDQUFDO0lBQ3BFQyxJQUFJLEVBQUU7TUFBRUMsTUFBTSxFQUFFVCxDQUFDLENBQUNLLGFBQWEsQ0FBQ0s7SUFBTSxDQUFDO0lBQ3ZDQyxPQUFPLFlBQUFDLFFBQUE7TUFBQSxTQUFBRCxRQUFBRSxFQUFBO1FBQUEsT0FBQUQsUUFBQSxDQUFBRSxLQUFBLE9BQUFDLFNBQUE7TUFBQTtNQUFBSixPQUFBLENBQUFLLFFBQUE7UUFBQSxPQUFBSixRQUFBLENBQUFJLFFBQUE7TUFBQTtNQUFBLE9BQUFMLE9BQUE7SUFBQSxFQUFFLFVBQUNNLE9BQU8sRUFBSztNQUNsQk4sT0FBTyxDQUFDTSxPQUFPLENBQUM7SUFDcEIsQ0FBQztJQUNEQyxLQUFLLFlBQUFDLE1BQUE7TUFBQSxTQUFBRCxNQUFBRSxHQUFBO1FBQUEsT0FBQUQsTUFBQSxDQUFBTCxLQUFBLE9BQUFDLFNBQUE7TUFBQTtNQUFBRyxLQUFBLENBQUFGLFFBQUE7UUFBQSxPQUFBRyxNQUFBLENBQUFILFFBQUE7TUFBQTtNQUFBLE9BQUFFLEtBQUE7SUFBQSxFQUFFLFVBQUNHLEdBQUcsRUFBSztNQUNaSCxLQUFLLENBQUNHLEdBQUcsQ0FBQ0MsWUFBWSxDQUFDTCxPQUFPLENBQUM7SUFDbkMsQ0FBQztFQUNMLENBQUMsQ0FBQztBQUNOLENBQUMsQ0FBQyJ9\n//# sourceURL=webpack-internal:///./Modules/Order/Resources/assets/admin/js/main.js\n");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module can't be inlined because the eval-source-map devtool is used.
/******/ 	var __webpack_exports__ = {};
/******/ 	__webpack_modules__["./Modules/Order/Resources/assets/admin/js/main.js"]();
/******/ 	
/******/ })()
;
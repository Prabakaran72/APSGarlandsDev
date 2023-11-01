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

/***/ "./Modules/User/Resources/assets/admin/js/main.js":
/*!********************************************************!*\
  !*** ./Modules/User/Resources/assets/admin/js/main.js ***!
  \********************************************************/
/***/ (() => {

eval("window.admin.removeSubmitButtonOffsetOn('#permissions');\n$('.permission-parent-actions > .allow-all, .permission-parent-actions > .deny-all, .permission-parent-actions > .inherit-all').on('click', function (e) {\n  var action = e.currentTarget.className.split(/\\s+/)[2].split(/-/)[0];\n  $(\".permission-\".concat(action)).prop('checked', true);\n});\n$('.permission-group-actions > .allow-all, .permission-group-actions > .deny-all, .permission-group-actions > .inherit-all').on('click', function (e) {\n  var action = e.currentTarget.className.split(/\\s+/)[2].split(/-/)[0];\n  $(e.currentTarget).closest('.permission-group').find(\".permission-\".concat(action)).each(function (index, value) {\n    $(value).prop('checked', true);\n  });\n});\n$('.delete-api-key').on('click', function (e) {\n  $('#confirmation-form').attr('action', e.currentTarget.dataset.action);\n});//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiLi9Nb2R1bGVzL1VzZXIvUmVzb3VyY2VzL2Fzc2V0cy9hZG1pbi9qcy9tYWluLmpzIiwibmFtZXMiOlsid2luZG93IiwiYWRtaW4iLCJyZW1vdmVTdWJtaXRCdXR0b25PZmZzZXRPbiIsIiQiLCJvbiIsImUiLCJhY3Rpb24iLCJjdXJyZW50VGFyZ2V0IiwiY2xhc3NOYW1lIiwic3BsaXQiLCJjb25jYXQiLCJwcm9wIiwiY2xvc2VzdCIsImZpbmQiLCJlYWNoIiwiaW5kZXgiLCJ2YWx1ZSIsImF0dHIiLCJkYXRhc2V0Il0sInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly9mbGVldGNhcnQvLi9Nb2R1bGVzL1VzZXIvUmVzb3VyY2VzL2Fzc2V0cy9hZG1pbi9qcy9tYWluLmpzP2QyMzkiXSwic291cmNlc0NvbnRlbnQiOlsid2luZG93LmFkbWluLnJlbW92ZVN1Ym1pdEJ1dHRvbk9mZnNldE9uKCcjcGVybWlzc2lvbnMnKTtcclxuXHJcbiQoJy5wZXJtaXNzaW9uLXBhcmVudC1hY3Rpb25zID4gLmFsbG93LWFsbCwgLnBlcm1pc3Npb24tcGFyZW50LWFjdGlvbnMgPiAuZGVueS1hbGwsIC5wZXJtaXNzaW9uLXBhcmVudC1hY3Rpb25zID4gLmluaGVyaXQtYWxsJykub24oJ2NsaWNrJywgKGUpID0+IHtcclxuICAgIGxldCBhY3Rpb24gPSBlLmN1cnJlbnRUYXJnZXQuY2xhc3NOYW1lLnNwbGl0KC9cXHMrLylbMl0uc3BsaXQoLy0vKVswXTtcclxuXHJcbiAgICAkKGAucGVybWlzc2lvbi0ke2FjdGlvbn1gKS5wcm9wKCdjaGVja2VkJywgdHJ1ZSk7XHJcbn0pO1xyXG5cclxuJCgnLnBlcm1pc3Npb24tZ3JvdXAtYWN0aW9ucyA+IC5hbGxvdy1hbGwsIC5wZXJtaXNzaW9uLWdyb3VwLWFjdGlvbnMgPiAuZGVueS1hbGwsIC5wZXJtaXNzaW9uLWdyb3VwLWFjdGlvbnMgPiAuaW5oZXJpdC1hbGwnKS5vbignY2xpY2snLCAoZSkgPT4ge1xyXG4gICAgbGV0IGFjdGlvbiA9IGUuY3VycmVudFRhcmdldC5jbGFzc05hbWUuc3BsaXQoL1xccysvKVsyXS5zcGxpdCgvLS8pWzBdO1xyXG5cclxuICAgICQoZS5jdXJyZW50VGFyZ2V0KS5jbG9zZXN0KCcucGVybWlzc2lvbi1ncm91cCcpXHJcbiAgICAgICAgLmZpbmQoYC5wZXJtaXNzaW9uLSR7YWN0aW9ufWApXHJcbiAgICAgICAgLmVhY2goKGluZGV4LCB2YWx1ZSkgPT4ge1xyXG4gICAgICAgICAgICAkKHZhbHVlKS5wcm9wKCdjaGVja2VkJywgdHJ1ZSk7XHJcbiAgICAgICAgfSk7XHJcbn0pO1xyXG5cclxuJCgnLmRlbGV0ZS1hcGkta2V5Jykub24oJ2NsaWNrJywgKGUpID0+IHtcclxuICAgICQoJyNjb25maXJtYXRpb24tZm9ybScpLmF0dHIoJ2FjdGlvbicsIGUuY3VycmVudFRhcmdldC5kYXRhc2V0LmFjdGlvbik7XHJcbn0pO1xyXG4iXSwibWFwcGluZ3MiOiJBQUFBQSxNQUFNLENBQUNDLEtBQUssQ0FBQ0MsMEJBQTBCLENBQUMsY0FBYyxDQUFDO0FBRXZEQyxDQUFDLENBQUMsNEhBQTRILENBQUMsQ0FBQ0MsRUFBRSxDQUFDLE9BQU8sRUFBRSxVQUFDQyxDQUFDLEVBQUs7RUFDL0ksSUFBSUMsTUFBTSxHQUFHRCxDQUFDLENBQUNFLGFBQWEsQ0FBQ0MsU0FBUyxDQUFDQyxLQUFLLENBQUMsS0FBSyxDQUFDLENBQUMsQ0FBQyxDQUFDLENBQUNBLEtBQUssQ0FBQyxHQUFHLENBQUMsQ0FBQyxDQUFDLENBQUM7RUFFcEVOLENBQUMsZ0JBQUFPLE1BQUEsQ0FBZ0JKLE1BQU0sQ0FBRSxDQUFDLENBQUNLLElBQUksQ0FBQyxTQUFTLEVBQUUsSUFBSSxDQUFDO0FBQ3BELENBQUMsQ0FBQztBQUVGUixDQUFDLENBQUMseUhBQXlILENBQUMsQ0FBQ0MsRUFBRSxDQUFDLE9BQU8sRUFBRSxVQUFDQyxDQUFDLEVBQUs7RUFDNUksSUFBSUMsTUFBTSxHQUFHRCxDQUFDLENBQUNFLGFBQWEsQ0FBQ0MsU0FBUyxDQUFDQyxLQUFLLENBQUMsS0FBSyxDQUFDLENBQUMsQ0FBQyxDQUFDLENBQUNBLEtBQUssQ0FBQyxHQUFHLENBQUMsQ0FBQyxDQUFDLENBQUM7RUFFcEVOLENBQUMsQ0FBQ0UsQ0FBQyxDQUFDRSxhQUFhLENBQUMsQ0FBQ0ssT0FBTyxDQUFDLG1CQUFtQixDQUFDLENBQzFDQyxJQUFJLGdCQUFBSCxNQUFBLENBQWdCSixNQUFNLENBQUUsQ0FBQyxDQUM3QlEsSUFBSSxDQUFDLFVBQUNDLEtBQUssRUFBRUMsS0FBSyxFQUFLO0lBQ3BCYixDQUFDLENBQUNhLEtBQUssQ0FBQyxDQUFDTCxJQUFJLENBQUMsU0FBUyxFQUFFLElBQUksQ0FBQztFQUNsQyxDQUFDLENBQUM7QUFDVixDQUFDLENBQUM7QUFFRlIsQ0FBQyxDQUFDLGlCQUFpQixDQUFDLENBQUNDLEVBQUUsQ0FBQyxPQUFPLEVBQUUsVUFBQ0MsQ0FBQyxFQUFLO0VBQ3BDRixDQUFDLENBQUMsb0JBQW9CLENBQUMsQ0FBQ2MsSUFBSSxDQUFDLFFBQVEsRUFBRVosQ0FBQyxDQUFDRSxhQUFhLENBQUNXLE9BQU8sQ0FBQ1osTUFBTSxDQUFDO0FBQzFFLENBQUMsQ0FBQyJ9\n//# sourceURL=webpack-internal:///./Modules/User/Resources/assets/admin/js/main.js\n");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module can't be inlined because the eval-source-map devtool is used.
/******/ 	var __webpack_exports__ = {};
/******/ 	__webpack_modules__["./Modules/User/Resources/assets/admin/js/main.js"]();
/******/ 	
/******/ })()
;
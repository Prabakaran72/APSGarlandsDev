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

eval("window.admin.removeSubmitButtonOffsetOn('#permissions');\n$('.permission-parent-actions > .allow-all, .permission-parent-actions > .deny-all, .permission-parent-actions > .inherit-all').on('click', function (e) {\n  var action = e.currentTarget.className.split(/\\s+/)[2].split(/-/)[0];\n  $(\".permission-\".concat(action)).prop('checked', true);\n});\n$('.permission-group-actions > .allow-all, .permission-group-actions > .deny-all, .permission-group-actions > .inherit-all').on('click', function (e) {\n  var action = e.currentTarget.className.split(/\\s+/)[2].split(/-/)[0];\n  $(e.currentTarget).closest('.permission-group').find(\".permission-\".concat(action)).each(function (index, value) {\n    $(value).prop('checked', true);\n  });\n});\n$('.delete-api-key').on('click', function (e) {\n  $('#confirmation-form').attr('action', e.currentTarget.dataset.action);\n});//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJuYW1lcyI6WyJ3aW5kb3ciLCJhZG1pbiIsInJlbW92ZVN1Ym1pdEJ1dHRvbk9mZnNldE9uIiwiJCIsIm9uIiwiZSIsImFjdGlvbiIsImN1cnJlbnRUYXJnZXQiLCJjbGFzc05hbWUiLCJzcGxpdCIsImNvbmNhdCIsInByb3AiLCJjbG9zZXN0IiwiZmluZCIsImVhY2giLCJpbmRleCIsInZhbHVlIiwiYXR0ciIsImRhdGFzZXQiXSwic291cmNlcyI6WyJ3ZWJwYWNrOi8vZmxlZXRjYXJ0Ly4vTW9kdWxlcy9Vc2VyL1Jlc291cmNlcy9hc3NldHMvYWRtaW4vanMvbWFpbi5qcz9kMjM5Il0sInNvdXJjZXNDb250ZW50IjpbIndpbmRvdy5hZG1pbi5yZW1vdmVTdWJtaXRCdXR0b25PZmZzZXRPbignI3Blcm1pc3Npb25zJyk7XHJcblxyXG4kKCcucGVybWlzc2lvbi1wYXJlbnQtYWN0aW9ucyA+IC5hbGxvdy1hbGwsIC5wZXJtaXNzaW9uLXBhcmVudC1hY3Rpb25zID4gLmRlbnktYWxsLCAucGVybWlzc2lvbi1wYXJlbnQtYWN0aW9ucyA+IC5pbmhlcml0LWFsbCcpLm9uKCdjbGljaycsIChlKSA9PiB7XHJcbiAgICBsZXQgYWN0aW9uID0gZS5jdXJyZW50VGFyZ2V0LmNsYXNzTmFtZS5zcGxpdCgvXFxzKy8pWzJdLnNwbGl0KC8tLylbMF07XHJcblxyXG4gICAgJChgLnBlcm1pc3Npb24tJHthY3Rpb259YCkucHJvcCgnY2hlY2tlZCcsIHRydWUpO1xyXG59KTtcclxuXHJcbiQoJy5wZXJtaXNzaW9uLWdyb3VwLWFjdGlvbnMgPiAuYWxsb3ctYWxsLCAucGVybWlzc2lvbi1ncm91cC1hY3Rpb25zID4gLmRlbnktYWxsLCAucGVybWlzc2lvbi1ncm91cC1hY3Rpb25zID4gLmluaGVyaXQtYWxsJykub24oJ2NsaWNrJywgKGUpID0+IHtcclxuICAgIGxldCBhY3Rpb24gPSBlLmN1cnJlbnRUYXJnZXQuY2xhc3NOYW1lLnNwbGl0KC9cXHMrLylbMl0uc3BsaXQoLy0vKVswXTtcclxuXHJcbiAgICAkKGUuY3VycmVudFRhcmdldCkuY2xvc2VzdCgnLnBlcm1pc3Npb24tZ3JvdXAnKVxyXG4gICAgICAgIC5maW5kKGAucGVybWlzc2lvbi0ke2FjdGlvbn1gKVxyXG4gICAgICAgIC5lYWNoKChpbmRleCwgdmFsdWUpID0+IHtcclxuICAgICAgICAgICAgJCh2YWx1ZSkucHJvcCgnY2hlY2tlZCcsIHRydWUpO1xyXG4gICAgICAgIH0pO1xyXG59KTtcclxuXHJcbiQoJy5kZWxldGUtYXBpLWtleScpLm9uKCdjbGljaycsIChlKSA9PiB7XHJcbiAgICAkKCcjY29uZmlybWF0aW9uLWZvcm0nKS5hdHRyKCdhY3Rpb24nLCBlLmN1cnJlbnRUYXJnZXQuZGF0YXNldC5hY3Rpb24pO1xyXG59KTtcclxuIl0sIm1hcHBpbmdzIjoiQUFBQUEsTUFBTSxDQUFDQyxLQUFLLENBQUNDLDBCQUEwQixDQUFDLGNBQWMsQ0FBQztBQUV2REMsQ0FBQyxDQUFDLDRIQUE0SCxDQUFDLENBQUNDLEVBQUUsQ0FBQyxPQUFPLEVBQUUsVUFBQ0MsQ0FBQyxFQUFLO0VBQy9JLElBQUlDLE1BQU0sR0FBR0QsQ0FBQyxDQUFDRSxhQUFhLENBQUNDLFNBQVMsQ0FBQ0MsS0FBSyxDQUFDLEtBQUssQ0FBQyxDQUFDLENBQUMsQ0FBQyxDQUFDQSxLQUFLLENBQUMsR0FBRyxDQUFDLENBQUMsQ0FBQyxDQUFDO0VBRXBFTixDQUFDLGdCQUFBTyxNQUFBLENBQWdCSixNQUFNLENBQUUsQ0FBQyxDQUFDSyxJQUFJLENBQUMsU0FBUyxFQUFFLElBQUksQ0FBQztBQUNwRCxDQUFDLENBQUM7QUFFRlIsQ0FBQyxDQUFDLHlIQUF5SCxDQUFDLENBQUNDLEVBQUUsQ0FBQyxPQUFPLEVBQUUsVUFBQ0MsQ0FBQyxFQUFLO0VBQzVJLElBQUlDLE1BQU0sR0FBR0QsQ0FBQyxDQUFDRSxhQUFhLENBQUNDLFNBQVMsQ0FBQ0MsS0FBSyxDQUFDLEtBQUssQ0FBQyxDQUFDLENBQUMsQ0FBQyxDQUFDQSxLQUFLLENBQUMsR0FBRyxDQUFDLENBQUMsQ0FBQyxDQUFDO0VBRXBFTixDQUFDLENBQUNFLENBQUMsQ0FBQ0UsYUFBYSxDQUFDLENBQUNLLE9BQU8sQ0FBQyxtQkFBbUIsQ0FBQyxDQUMxQ0MsSUFBSSxnQkFBQUgsTUFBQSxDQUFnQkosTUFBTSxDQUFFLENBQUMsQ0FDN0JRLElBQUksQ0FBQyxVQUFDQyxLQUFLLEVBQUVDLEtBQUssRUFBSztJQUNwQmIsQ0FBQyxDQUFDYSxLQUFLLENBQUMsQ0FBQ0wsSUFBSSxDQUFDLFNBQVMsRUFBRSxJQUFJLENBQUM7RUFDbEMsQ0FBQyxDQUFDO0FBQ1YsQ0FBQyxDQUFDO0FBRUZSLENBQUMsQ0FBQyxpQkFBaUIsQ0FBQyxDQUFDQyxFQUFFLENBQUMsT0FBTyxFQUFFLFVBQUNDLENBQUMsRUFBSztFQUNwQ0YsQ0FBQyxDQUFDLG9CQUFvQixDQUFDLENBQUNjLElBQUksQ0FBQyxRQUFRLEVBQUVaLENBQUMsQ0FBQ0UsYUFBYSxDQUFDVyxPQUFPLENBQUNaLE1BQU0sQ0FBQztBQUMxRSxDQUFDLENBQUMiLCJmaWxlIjoiLi9Nb2R1bGVzL1VzZXIvUmVzb3VyY2VzL2Fzc2V0cy9hZG1pbi9qcy9tYWluLmpzIiwic291cmNlUm9vdCI6IiJ9\n//# sourceURL=webpack-internal:///./Modules/User/Resources/assets/admin/js/main.js\n");

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
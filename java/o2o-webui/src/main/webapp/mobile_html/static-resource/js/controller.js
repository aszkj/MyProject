/**
 * Created by Administrator on 2016/10/22.
 */
// register.html
angular.module('register', []).controller('registerController',
				function($scope) {
					$scope.user = {};
					$scope.telemsg = function() {
;						return checkMobile($("#tele").val());
					};
					$scope.telemsg1 = function() {
;						return checkMobile($("#tele1").val());
					};
					$scope.passwordMsg=function(){
						return checkPassword($("#password").val());
					};
					$scope.validatePassword=function(){
						return validaPassword();
					}
				});
angular.module('index', []).controller('indexController', function($scope) {

});
angular.module('bindTele', []).controller('bindTeleController',
		function($scope) {
			$scope.user = {};
		});
angular.module('general', []).controller('generalController', function($scope) {

});
var rec=angular.module('rec', []);
rec.controller('recController', function($scope) {

});

// Generated by CoffeeScript 1.8.0
(function() {
  var app, calculateDistance, debounce;

  debounce = function(func, wait, immediate) {
    var timeout;
    timeout = void 0;
    return function() {
      var args, callNow, context, later;
      context = this;
      args = arguments;
      later = function() {
        timeout = null;
        if (!immediate) {
          func.apply(context, args);
        }
      };
      callNow = immediate && !timeout;
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
      if (callNow) {
        return func.apply(context, args);
      }
    };
  };

  calculateDistance = function(elem, mouseX, mouseY) {
    return {
      x: Math.floor(Math.sqrt(Math.pow(mouseX - (elem.offset().left + elem.width() / 2), 2))),
      y: Math.floor(Math.sqrt(Math.pow(mouseY - (elem.offset().top + elem.height() / 2), 2)))
    };
  };

  app = angular.module('tejas', ['ngAnimate', 'ui.router']).directive('expandLetter', function($timeout) {
    return {
      link: function(scope, element, attrs) {
        return $timeout(function() {
          return angular.element(element).addClass('expanded');
        }, 2000);
      }
    };
  }).directive('layer', function() {
    return {
      link: function(scope, element, attrs) {
        return jQuery(element).bind('click', function() {
          return scope.$apply(function() {
            if (jQuery('.layers').hasClass('transformed')) {
              return scope.open_layer(attrs.layer);
            }
          });
        });
      }
    };
  }).directive('moveTheLayers', function() {
    return {
      link: function(scope, element, attrs) {
        var mousemove;
        jQuery(element).bind('touchstart', function(e) {
          return scope.$apply(function() {
            return $('.layers.transformed').css('transition-timing-function', 'ease');
          });
        });
        jQuery(element).bind('touchmove', function(e) {
          return debounce(scope.$apply(function() {
            return $('.layers.transformed').css('transform', 'translateX(-70px) translateY(-50%) rotateX(' + e.originalEvent.touches[0].screenY / 10 + 'deg) rotateY(' + e.originalEvent.touches[0].screenX / 10 + 'deg) rotateZ(20deg) skew(-11deg, 0deg)');
          }), 250);
        });
        mousemove = function(e) {
          var distance;
          distance = calculateDistance($(e.originalEvent.srcElement), e.clientX, e.clientY);
          distance = distance.x;
          if (distance > 50) {
            return scope.$apply(function() {
              return $('.layers.transformed').css('perspective', distance + 'px');
            });
          }
        };
        return jQuery(element).on('mousemove', mousemove);
      }
    };
  }).controller('site', function($scope, $sce) {
    $scope.layer = {
      active: 'home'
    };
    $scope.layers = {
      open: false
    };
    return $scope.open_layer = function(layer) {
      console.log($scope.layers.open);
      if ($scope.layers.open) {
        $scope.layers.open = false;
      } else {
        $scope.layers.open = true;
      }
      $scope.layer.active = layer;
      return $scope.technologies = [
        {
          slug: 'html',
          text: $sce.trustAsHtml('<code>&lt;p&gt;This is essential.<br>I learned HTML4 when I was 8 years old and seamlessly upgraded when the HTML5 came out.&lt;/p&gt;</code>')
        }, {
          slug: 'jade',
          text: $sce.trustAsHtml("<code>html<br>&nbsp;&nbsp;head<br>&nbsp;&nbsp;&nbsp;&nbsp;title I love this.<br>&nbsp;&nbsp;body<br>&nbsp;&nbsp;&nbsp;&nbsp;p Hello<br>&nbsp;&nbsp;&nbsp;&nbsp;p My name is Tejas</code>")
        }, {
          slug: 'css',
          text: $sce.trustAsHtml("<code>animation: dance .6s infinite;</code><br><div class='dancer'></div>")
        }, {
          slug: 'sass',
          text: $sce.trustAsHtml("<code>$soAreVariables: rgba(white, 0.5);<br><br>.nesting {<br>&nbsp;&nbsp;.is-cool {<br>&nbsp;&nbsp;&nbsp;&nbsp;color: <br>&nbsp;&nbsp;&nbsp;&nbsp;$soAreVariables; } }</code>")
        }, {
          slug: 'foundation',
          text: $sce.trustAsHtml("<code>&lt;div class='row'&gt;<br>&nbsp;&nbsp;&lt;div class='small-6 medium-4 large-2 columns'&gt;Sup, columns?&lt;/div&gt;<br>&nbsp;&nbsp;&lt;div class='small-6 medium-4 large-2 columns'&gt;Foundation in tha house.&lt;/div&gt;<br>&lt;/div&gt;</code>")
        }, {
          slug: 'bootstrap',
          text: $sce.trustAsHtml("<code>&lt;div class='col-sm-6 col-md-4 col-lg-2'>Sup, columns? Bootstrap in tha house.&lt;/div&gt;</code>")
        }, {
          slug: 'js',
          text: $sce.trustAsHtml("<code>var tejas = { <br>&nbsp;&nbsp;race: 'indian', <br>&nbsp;&nbsp;loves: 'people, code', <br>&nbsp;&nbsp;eats: 'food', <br>&nbsp;&nbsp;sleep: function(){ <br>&nbsp;&nbsp;&nbsp;&nbsp;throw 'too busy,<br>&nbsp;&nbsp;&nbsp; cannot!'; } <br>};</code>")
        }, {
          slug: 'angularjs',
          text: $sce.trustAsHtml("<code>var myApp = angular.module('myapp', ['ngAnimate', 'ui.router']);</code>")
        }, {
          slug: 'jquery',
          text: $sce.trustAsHtml("<code>$(document).ready(<br>function(){<br>&nbsp;&nbsp;//DOM manipulation is &nbsp;&nbsp;cool!<br>});</code>")
        }, {
          slug: 'coffeescript',
          text: $sce.trustAsHtml("<code>forcedIndents = 'sometimes annoying'<br><br>implicitReturns = 'Also sometimes annoying'<br><br>arrowFunctions = -> <br>&nbsp;&nbsp;'Cool!'</code>")
        }, {
          slug: 'git',
          text: $sce.trustAsHtml("<code>git init<br>git add .<br>git commit -am 'Version control is the best.'</code>")
        }, {
          slug: 'grunt',
          text: $sce.trustAsHtml("<code>grunt cssmin uglify</code>")
        }, {
          slug: 'nodejs',
          text: $sce.trustAsHtml("<code>var http = require('http');<br><br>var server = http.createServer(<br>(request, response) =><br>&nbsp;&nbsp;response.writeHead(200, {'Content-Type': 'text/plain'});<br> });</code>")
        }, {
          slug: 'php',
          text: $sce.trustAsHtml("<code>&lt;php<br>&nbsp;&nbsp;echo 'This is cool. I learned this in 2008.';<br>?&gt;</code>")
        }, {
          slug: 'mysql',
          text: $sce.trustAsHtml("<code>SELECT `developer` FROM `developers` WHERE `skills` = 'so good'; #Find Tejas.</code>")
        }
      ];
    };
  });

}).call(this);

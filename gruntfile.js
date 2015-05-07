module.exports = function(grunt){
    
    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-jade');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-cssmin');
    grunt.loadNpmTasks('grunt-banner');
    
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        
        coffee: {
            glob_to_multiple: {
                expand: true,
                flatten: true,
                src: ['coffee/*.coffee'],
                dest: 'www/js/',
                ext: '.js',
                extDot: 'last'
            }   
        },
      
        jade: {
          dist: {
            options: {
              pretty: true
            },
            files: {
              "www/index.html": "jade/index.jade"
            }
          }
        },
        
        sass: {
            dist: {
              files: [{
                cwd: 'scss',
                expand: true,
                src: ['*.scss'],
                dest: 'www/css/',
                ext: '.css'
              }]
            }
          },
      
        uglify: {
          options: {
            mangle: false
          },
          my_target: {
            files: {
              'www/js/main.js': ['www/js/main.js'],
              'www/js/jquery.sketchpad.min.js': ['www/js/jquery.sketchpad.min.js']
            }
          }
        },
      
        cssmin: {
          target: {
            files: {
              'www/css/main.css': ['www/css/main.css']
            }
          }
        }
    
    });
    grunt.registerTask('default', ['coffee', 'jade', 'sass']);
    
}
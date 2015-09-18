module.exports = function(grunt) {
	
	grunt.initConfig({
		less: {
			core: {
				src: "build/less/design.less",
				dest: "build/css/design.css",
			},
		},
		cssmin: {
			css: {
				src: "build/css/design.css",
				dest: "build/css/design.min.css",
			},
		},
		watch: {
			less: {
			    files: ['build/less/*.less', 'build/less/pages/*.less'],
			    tasks: ['less'],
			},
			cssmin: {
				files: ['build/css/design.css'],
				tasks: ['cssmin'],
			},
		},
	});

	grunt.registerTask('default', ['watch']);
	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-contrib-cssmin');
	grunt.loadNpmTasks('grunt-contrib-watch');
}
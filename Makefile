install:
	rm -f *.gem
	gem build vcf.gemspec
	sudo gem uninstall -a vcf || echo "vcf was not already installed"
	sudo gem install vcf-*.*.*.gem

install_remote:
	sudo gem uninstall -a vcf || echo "vcf was not already installed"
	sudo gem insall vcf

push:
	rm -f *.gem
	gem build vcf.gemspec
	gem push vcf-*.*.*.gem

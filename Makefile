before:
	@rm -rf src
	@cp -r testsrc/before src

after:
	@rm -rf src
	@cp -r testsrc/after src

cleanup:
	@make before

bench:
	@make bench-base
	@make bench-echo
	@make bench-cargochef
	@make bench-buildkit-base
	@make bench-buildkit-sccache

bench-base:
	@make before
	@docker build -q -f Dockerfile.base -t rust-docker-base .
	@make after
	@echo "Time of Dockerfile.base"
	@time docker build -q -f Dockerfile.base -t rust-docker-base .
	@make cleanup

bench-echo:
	@make before
	@docker build -q -f Dockerfile.echo -t rust-docker-echo .
	@make after
	@echo "Time of Dockerfile.echo"
	@time docker build -q -f Dockerfile.echo -t rust-docker-echo .
	@make cleanup

bench-cargochef:
	@make before
	@docker build -q -f Dockerfile.cargochef -t rust-docker-cargochef .
	@make after
	@echo "Time of Dockerfile.cargochef"
	@time docker build -q -f Dockerfile.cargochef -t rust-docker-cargochef .
	@make cleanup

bench-buildkit-base:
	@make before
	@DOCKER_BUILDKIT=1 docker build -q -f Dockerfile.buildkit-base -t rust-docker-buildkit-base .
	@make after
	@echo "Time of Dockerfile.buildkit-base"
	@DOCKER_BUILDKIT=1 time docker build -q -f Dockerfile.buildkit-base -t rust-docker-buildkit-base .
	@make cleanup

bench-buildkit-sccache:
	@make before
	@DOCKER_BUILDKIT=1 docker build -q -f Dockerfile.buildkit-sccache -t rust-docker-buildkit-sccache .
	@make after
	@echo "Time of Dockerfile.buildkit-sccache"
	@DOCKER_BUILDKIT=1 time docker build -q -f Dockerfile.buildkit-sccache -t rust-docker-buildkit-sccache .
	@make cleanup

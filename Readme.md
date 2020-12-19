# Rust Dockerfile Comparison

When building a container image of an application written in Rust, there are several ways to write the Dockerfile.
This repository compared the build time of the image for each cases.

(This repository is not concerned about the build image size. It doesn't expect to develop in the cargo workspace)

## How to compare

Once the image has been built, change the code and rebuild the image. Repeat it for each Dockerfile. 
For scripts and Dockerfiles, see [Makefile](https://github.com/mkazutaka/rust-dockerifle-compare/blob/main/Makefile#L12-L17) and `Docker.*`.

## Run

Clone this repository and do following.

```shell
make bench
```

## Result

The fastest is [Dockerfile.buildkit-base](https://github.com/mkazutaka/rust-dockerifle-compare/blob/main/Dockerfile.buildkit-base) in my env.

```text
Time of Dockerfile.buildkit-base
       15.63 real         0.15 user         0.08 sys
Time of Dockerfile.cargochef
       18.81 real         3.05 user         0.92 sys
Time of Dockerfile.echo
       22.82 real         3.00 user         0.92 sys
Time of Dockerfile.buildkit-sccache
       35.12 real         0.16 user         0.09 sys
Time of Dockerfile.base
       90.60 real         2.93 user         0.89 sys
```

The following PC was used for the benchmark.
To be sure, I recoomend to run `docker system prune -f -a` before running the benchmark.

```text
macOS Catalina v10.15.7
MacBook Pro (16-inch, 2019)
Processor 2.4GHz 8-Core Intel Core i9
Memory 64GB 2667 MHz DDR4
```

If you have any other ideas, please comment, Github Issue, or PR!

## Ref

- [Cache Rust dependencies with Docker build - Stack Overflow](https://stackoverflow.com/questions/58473606/cache-rust-dependencies-with-docker-build)
- [cargo build --dependencies-only · Issue #2644 · rust-lang/cargo](https://github.com/rust-lang/cargo/issues/2644)
- [Rust - Fast + Small Docker Image Builds](https://shaneutt.com/blog/rust-fast-small-docker-image-builds/)
- [LukeMathWalker/cargo-chef: A cargo-subcommand to speed up Rust Docker builds using Docker layer caching.](https://github.com/LukeMathWalker/cargo-chef)
- [benmarten/sccache-docker-test](https://github.com/benmarten/sccache-docker-test)
- [Build images with BuildKit | Docker Documentation](https://docs.docker.com/develop/develop-images/build_enhancements/)
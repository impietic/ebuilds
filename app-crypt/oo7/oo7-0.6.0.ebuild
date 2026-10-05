# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER=1.92.0

CRATES="
	aes@0.8.4
	aho-corasick@1.1.4
	anstream@0.6.21
	anstyle-parse@0.2.7
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.13
	anyhow@1.0.102
	ashpd@0.13.0
	async-broadcast@0.7.2
	async-channel@2.5.0
	async-executor@1.14.0
	async-fs@2.2.0
	async-io@2.6.0
	async-lock@3.4.2
	async-process@2.5.0
	async-recursion@1.1.1
	async-signal@0.2.13
	async-task@4.7.1
	async-trait@0.1.89
	atomic-waker@1.1.2
	autocfg@1.5.0
	base64@0.22.1
	bitflags@2.11.0
	block-buffer@0.10.4
	block-padding@0.3.3
	block@0.1.6
	blocking@1.6.2
	bumpalo@3.20.2
	bytes@1.11.1
	cargo-credential@0.4.9
	cbc@0.1.2
	cc@1.2.56
	cfg-if@1.0.4
	cipher@0.4.4
	clap@4.5.60
	clap_builder@4.5.60
	clap_derive@4.5.55
	clap_lex@1.0.0
	colorchoice@1.0.4
	concurrent-queue@2.5.0
	cpufeatures@0.2.17
	crossbeam-utils@0.8.21
	crypto-common@0.1.7
	deranged@0.5.7
	digest@0.10.7
	endi@1.1.1
	enumflags2@0.7.12
	enumflags2_derive@0.7.12
	equivalent@1.0.2
	errno@0.3.14
	event-listener-strategy@0.5.4
	event-listener@5.4.1
	fastrand@2.3.0
	find-msvc-tools@0.1.9
	foldhash@0.1.5
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	formatx@0.2.4
	futures-channel@0.3.32
	futures-core@0.3.32
	futures-executor@0.3.32
	futures-io@0.3.32
	futures-lite@2.6.1
	futures-macro@0.3.32
	futures-task@0.3.32
	futures-util@0.3.32
	generic-array@0.14.7
	getrandom@0.3.4
	getrandom@0.4.1
	gettext-rs@0.7.7
	gettext-sys@0.26.0
	hashbrown@0.15.5
	hashbrown@0.16.1
	heck@0.5.0
	hermit-abi@0.5.2
	hex@0.4.3
	hkdf@0.12.4
	hmac@0.12.1
	id-arena@2.3.0
	indexmap@2.13.0
	inout@0.1.4
	is_terminal_polyfill@1.70.2
	itoa@1.0.17
	js-sys@0.3.87
	lazy_static@1.5.0
	leb128fmt@0.1.0
	libc@0.2.182
	libm@0.2.16
	linux-raw-sys@0.11.0
	locale_config@0.3.0
	lock_api@0.4.14
	log@0.4.29
	malloc_buf@0.0.6
	matchers@0.2.0
	md-5@0.10.6
	memchr@2.8.0
	memoffset@0.9.1
	mio@1.1.1
	nu-ansi-term@0.50.3
	num-bigint-dig@0.9.1
	num-bigint@0.4.6
	num-complex@0.4.6
	num-conv@0.2.0
	num-integer@0.1.46
	num-iter@0.1.45
	num-rational@0.4.2
	num-traits@0.2.19
	num@0.4.3
	num_threads@0.1.7
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	once_cell@1.21.3
	once_cell_polyfill@1.70.2
	openssl-macros@0.1.1
	openssl-sys@0.9.111
	openssl@0.10.75
	ordered-stream@0.2.0
	parking@2.2.1
	parking_lot@0.12.5
	parking_lot_core@0.9.12
	pbkdf2@0.12.2
	pin-project-lite@0.2.16
	piper@0.2.4
	pkg-config@0.3.32
	polling@3.11.0
	portable-atomic@1.13.1
	powerfmt@0.2.0
	ppv-lite86@0.2.21
	prettyplease@0.2.37
	proc-macro-crate@3.4.0
	proc-macro2@1.0.106
	pyo3-async-runtimes@0.28.0
	pyo3-build-config@0.28.2
	pyo3-ffi@0.28.2
	pyo3-macros-backend@0.28.2
	pyo3-macros@0.28.2
	pyo3@0.28.2
	quote@1.0.44
	r-efi@5.3.0
	rand@0.9.2
	rand_chacha@0.9.0
	rand_core@0.9.5
	redox_syscall@0.5.18
	regex-automata@0.4.14
	regex-syntax@0.8.9
	regex@1.12.3
	rpassword@7.4.0
	rtoolbox@0.0.3
	rustix@1.1.3
	rustversion@1.0.22
	scc@2.4.0
	scopeguard@1.2.0
	sdd@3.0.10
	semver@1.0.27
	serde@1.0.228
	serde_bytes@0.11.19
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.149
	serde_repr@0.1.20
	serial_test@3.3.1
	serial_test_derive@3.3.1
	sha2@0.10.9
	sharded-slab@0.1.7
	shlex@1.3.0
	signal-hook-registry@1.4.8
	slab@0.4.12
	smallvec@1.15.1
	socket2@0.6.2
	strsim@0.11.1
	subtle@2.6.1
	syn@2.0.117
	target-lexicon@0.13.5
	temp-dir@0.1.16
	tempfile@3.25.0
	thiserror-impl@2.0.18
	thiserror@2.0.18
	thread_local@1.1.9
	time-core@0.1.8
	time-macros@0.2.27
	time@0.3.47
	tokio-macros@2.6.0
	tokio-stream@0.1.18
	tokio@1.49.0
	toml_datetime@0.7.5+spec-1.1.0
	toml_edit@0.23.10+spec-1.0.0
	toml_parser@1.0.9+spec-1.1.0
	tracing-attributes@0.1.31
	tracing-core@0.1.36
	tracing-journald@0.3.2
	tracing-log@0.2.0
	tracing-subscriber@0.3.22
	tracing@0.1.44
	typenum@1.19.0
	uds_windows@1.1.0
	unicode-ident@1.0.24
	unicode-xid@0.2.6
	utf8parse@0.2.2
	uuid@1.21.0
	valuable@0.1.1
	vcpkg@0.2.15
	version_check@0.9.5
	wasi@0.11.1+wasi-snapshot-preview1
	wasip2@1.0.2+wasi-0.2.9
	wasip3@0.4.0+wasi-0.3.0-rc-2026-01-06
	wasm-bindgen-macro-support@0.2.110
	wasm-bindgen-macro@0.2.110
	wasm-bindgen-shared@0.2.110
	wasm-bindgen@0.2.110
	wasm-encoder@0.244.0
	wasm-metadata@0.244.0
	wasmparser@0.244.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-link@0.2.1
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-sys@0.60.2
	windows-sys@0.61.2
	windows-targets@0.52.6
	windows-targets@0.53.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.1
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.1
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.1
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.1
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.1
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.1
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.1
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.1
	winnow@0.7.14
	wit-bindgen-core@0.51.0
	wit-bindgen-rust-macro@0.51.0
	wit-bindgen-rust@0.51.0
	wit-bindgen@0.51.0
	wit-component@0.244.0
	wit-parser@0.244.0
	zbus@5.13.2
	zbus_macros@5.13.2
	zbus_names@4.3.1
	zerocopy-derive@0.8.39
	zerocopy@0.8.39
	zeroize@1.8.2
	zeroize_derive@1.4.3
	zmij@1.0.21
	zvariant@5.9.2
	zvariant_derive@5.9.2
	zvariant_utils@3.3.0
"

inherit cargo meson pam systemd

DESCRIPTION="Secret Service daemon, secret portal and PAM module"
HOMEPAGE="https://github.com/linux-credentials/oo7"
SRC_URI="
	https://github.com/linux-credentials/oo7/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD MIT Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pam"

RDEPEND="
	!gnome-base/gnome-keyring
	sys-apps/systemd
	pam? ( sys-libs/pam )
"
BDEPEND="
	>=dev-build/meson-1.7.0
	sys-devel/gettext
"

src_configure() {
	local emesonargs=(
		-Dsystemd=enabled
		-Dsystemduserunitdir="$(systemd_get_userunitdir)"
	)

	local dir
	for dir in server portal; do
		EMESON_SOURCE=${S}/${dir} BUILD_DIR=${S}/${dir}/build meson_src_configure
	done

	if use pam; then
		local emesonargs=( -Dpam_moduledir="$(getpam_mod_dir)" )
		EMESON_SOURCE=${S}/pam BUILD_DIR=${S}/pam/build meson_src_configure
	fi
}

src_compile() {
	local dir
	for dir in server portal $(usev pam); do
		BUILD_DIR=${S}/${dir}/build cargo_env meson_src_compile
	done
}

src_install() {
	local dir
	for dir in server portal $(usev pam); do
		BUILD_DIR=${S}/${dir}/build meson_src_install
	done

	# pam_oo7 auto_start execs this hardcoded path
	dosym ../libexec/oo7-daemon /usr/bin/oo7-daemon
	dosym ../oo7-daemon.service "$(systemd_get_userunitdir)"/default.target.wants/oo7-daemon.service
}

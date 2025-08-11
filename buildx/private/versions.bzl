"""Mirror of release info

TODO: generate this file from GitHub API"""

# The integrity hashes can be computed with
# shasum -b -a 384 [downloaded file] | awk '{ print $1 }' | xxd -r -p | base64
BUILDX_VERSIONS = {
    "0.22.0": {
        "linux-arm64": "6e9e455b5ec1c7ac708f2640a86c5cecce38c72e48acff6cb219dfdfa2dda781",
        "linux-amd64": "805195386fba0cea5a1487cf0d47da82a145ea0a792bd3fb477583e2dbcdcc2f",
        "darwin-arm64": "5898c338abb1f673107bc087997dc3cb63b4ea66d304ce4223472f57bd8d616e",
        "darwin-amd64": "5221ad6b8acd2283f8fbbeebc79ae4b657e83519ca1c1e4cfbb9405230b3d933",
    },
}

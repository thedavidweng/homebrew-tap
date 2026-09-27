class JobsCli < Formula
  desc "Agent-friendly CLI for job discovery and applications"
  homepage "https://github.com/thedavidweng/jobs-cli"
  head "https://github.com/thedavidweng/jobs-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    # The module path gains a /vN suffix with each major release; read it
    # from go.mod so the -X target keeps matching the version package.
    module_path = (buildpath/"go.mod").read[/^module\s+(\S+)/, 1]
    ldflags = %W[
      -s
      -w
      -X #{module_path}/internal/version.BuiltBy=homebrew
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/jobs-cli"
  end

  test do
    output = shell_output("#{bin}/jobs-cli --json version")
    assert_match '"ok":true', output
    assert_match '"command":"version"', output
    assert_match "jobs-cli", shell_output("#{bin}/jobs-cli completion bash")
  end
end

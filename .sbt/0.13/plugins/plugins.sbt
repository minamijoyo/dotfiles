// sbt-ensime
addSbtPlugin("org.ensime" % "sbt-ensime" % "2.0.2")

// sbt-ctags
resolvers ++= Seq(
  "Sonatype OSS Releases" at "https://oss.sonatype.org/content/repositories/releases/",
  "Sonatype OSS Snapshots" at "https://oss.sonatype.org/content/repositories/snapshots/"
)
addSbtPlugin("net.ceedubs" %% "sbt-ctags" % "0.2.0")

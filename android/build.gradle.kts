allprojects {
    repositories {
        // Local Flutter engine artifacts mirror (used to bypass corporate SSL proxy blocking .jar downloads
        // from storage.googleapis.com). Regenerate with: bash /tmp/setup_flutter_maven.sh
        maven {
            url = uri("file://${System.getProperty("user.home")}/.flutter-local-maven")
        }
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

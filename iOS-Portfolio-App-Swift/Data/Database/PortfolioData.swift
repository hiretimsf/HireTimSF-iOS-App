import Foundation

enum PortfolioData {
    static let websiteURL = url("https://hiretimsf.com")
    static let fallbackImageURL = url("https://hiretimsf.com/images/logo.png")

    static let profile = Profile(
        greeting: "Nice to meet you",
        name: "Tim Baz",
        title: "Design Engineer",
        email: "hiretimsf@gmail.com",
        socials: [
            SocialLink(id: "x", name: "X (Twitter)", url: url("https://x.com/hiretimsf"), systemImage: "bubble.left.and.bubble.right"),
            SocialLink(id: "github", name: "GitHub", url: url("https://github.com/hiretimsf"), systemImage: "chevron.left.forwardslash.chevron.right"),
            SocialLink(id: "linkedin", name: "LinkedIn", url: url("https://www.linkedin.com/in/hiretimsf/"), systemImage: "person.crop.square")
        ]
    )

    static let welcome = [
        WelcomePage(
            title: "Hello",
            subtitle: "I'm Tim,",
            text: "I am a Design Engineer based in the San Francisco Bay Area.",
            imageName: "onboarding_01"
        ),
        WelcomePage(
            title: "Background",
            subtitle: "Modern web apps,",
            text: "I build web and Android apps using Next.js, React, TypeScript, Tailwind CSS, Kotlin, and Jetpack Compose.",
            imageName: "onboarding_02"
        ),
        WelcomePage(
            title: "Passion",
            subtitle: "My portfolio",
            text: "I built this app to share my work.",
            imageName: "onboarding_03"
        )
    ]

    static let aboutSections = [
        AboutSection(
            title: "Introduction",
            content: "I am a Design Engineer with more than 5 years of experience building modern web applications with Next.js, TailwindCSS, and TypeScript.\n\nI currently live in the San Francisco Bay Area with my family. I am originally from Mongolia and studied Computer Science in Germany. I speak English, German, and Mongolian, and I also understand some Russian."
        ),
        AboutSection(
            title: "How I got started",
            content: "After college, I started with Android development using my Java and XML background. I published several apps on the Google Play Store, building with Java, Kotlin, XML, Material Design, and Jetpack components."
        ),
        AboutSection(
            title: "Web Development",
            content: "I started learning Next.js and Tailwind CSS in late 2022 while working full-time at a factory. It was difficult to balance both, so I quit my job and moved to Mongolia for a lower cost of living. I spent three focused months there learning Next.js, React, TypeScript, and Tailwind CSS.\n\nDuring that time, I met my wife. We got married, our daughter was born, and we came back to the U.S. in late 2023. I kept learning and building side projects, including portfolio apps. One of my projects now has 460+ stars on GitHub, and another was mentioned on WeAreDevelopers.com."
        ),
        AboutSection(
            title: "Today",
            content: "In 2026, I completed my first paid client project with Next.js, React, TypeScript, and Tailwind CSS: a restaurant website with client login and a booking system. You can visit the live site at choijin.mn.\n\nI am currently building my first SaaS product, Menu CEO, an online restaurant menu platform.\n\nTo learn more, visit my blog and education pages."
        )
    ]

    static let aboutPhotos = [
        AboutPhoto(url: url("https://hiretimsf.com/images/about/about_me_01.webp"), alt: "Tim's wedding photo showing a special moment with his wife"),
        AboutPhoto(url: url("https://hiretimsf.com/images/about/about_me_02.webp"), alt: "Tim with his family in a warm family moment"),
        AboutPhoto(url: url("https://hiretimsf.com/images/about/about_me_03.webp"), alt: "Tim running, showing his active lifestyle and fitness")
    ]

    static let projects = [
        Project(
            id: "YvlbIeO4gwikTqhO3bF8",
            title: "Portfolio App",
            subtitle: "Portfolio App 2.0",
            header: "Android Apps",
            coverImage: url("https://tumur.me/img/portfolio_screen.jpg"),
            logo: URL(string: "https://tumur.me/img/portfolio-app-icon.png"),
            imageDescription: "User profile screen",
            info: "Kotlin, Jetpack, MVVM",
            text: "This is the latest version of my portfolio app where I want to share my skills and passion for Android development. It is a result of what I learned with Kotlin, Android Jetpack, Material Design, Firebase components, Retrofit, OkHttp, Glide, LeakCanary, Koin, and Kotlin Coroutines.",
            start: "Nov 2018",
            end: "Aug 2019",
            links: [
                ProjectLink(title: "GitHub", url: url("https://github.com/tumurb/Portfolio-Verson-2/"), systemImage: "chevron.left.forwardslash.chevron.right"),
                ProjectLink(title: "Play Store", url: url("https://play.google.com/store/apps/details?id=hiretimsf.com.app"), systemImage: "arrow.up.forward.app")
            ]
        ),
        Project(
            id: "2LinPN2Mh8oBunXcepf1",
            title: "Ponda App",
            subtitle: "Read Key Ideas",
            header: "Android Apps",
            coverImage: url("https://tumur.me/img/ponda_screen.jpg"),
            logo: URL(string: "https://tumur.me/img/ponda-app-icon.png"),
            imageDescription: "Home screen",
            info: "Kotlin, Jetpack, MVVM",
            text: "Helps people read key ideas from best-selling personal development books. The app provides text and audio formats and supports accessibility for visually impaired and blind users.",
            start: "Nov 2018",
            end: "Aug 2019",
            links: [
                ProjectLink(title: "GitHub", url: url("https://github.com/tumurb/Mongolian-Sign-Language-Dictionary"), systemImage: "chevron.left.forwardslash.chevron.right"),
                ProjectLink(title: "Play Store", url: url("https://play.google.com/store/apps/dev?id=4872099625526337244"), systemImage: "arrow.up.forward.app")
            ]
        ),
        Project(
            id: "iRKgF6SOYc76Xkpgl2WT",
            title: "Portfolio App 1.0",
            subtitle: "Portfolio App 1.0",
            header: "Android Apps",
            coverImage: url("https://tumur.me/img/resume_screen.jpg"),
            logo: URL(string: "https://tumur.me/img/resume-icon.png"),
            imageDescription: "User profile screen",
            info: "Java, Android, MVC",
            text: "Portfolio app 1.0 is a simple Java Android application for showing my skills and passion for Android development. It was built with standard Android SDK APIs and an MVC architecture.",
            start: "May 2018",
            end: "Feb 2019",
            links: [
                ProjectLink(title: "GitHub", url: url("https://github.com/tumurb/Personal-Resume-Android"), systemImage: "chevron.left.forwardslash.chevron.right"),
                ProjectLink(title: "Download", url: url("https://drive.google.com/file/d/1k42IA8ypeBl-idalp9RRwxPzz3UugQCw/view"), systemImage: "square.and.arrow.down")
            ]
        )
    ]

    static let blogPosts = [
        BlogPost(
            slug: "android-compose-notes",
            title: "Building calmer Android screens with Compose",
            date: "May 2026",
            category: "Android",
            readTime: "4 min read",
            excerpt: "Placeholder notes for a future post about replacing legacy screens with focused Compose UI.",
            coverImageUrl: url("https://hiretimsf.com/images/blog/android-compose-portfolio-app/cover.jpg"),
            imageAlt: "Blog cover placeholder",
            url: nil,
            sections: [],
            content: "",
            author: "Tim Baz",
            authorAvatarUrl: URL(string: "https://hiretimsf.com/images/logo.png"),
            tags: ["Android", "Compose"]
        )
    ]

    static let appInfo = [
        AppInfoItem(title: "Current Version", text: "1.5.2"),
        AppInfoItem(title: "Latest Version", text: "1.5.2"),
        AppInfoItem(title: "Last updated", text: "June 23, 2019")
    ]

    static let sourceCodeURL = url("https://github.com/hiretimsf")
    static let privacyURL = url("https://hiretimsf.com/privacy")
    static let rateURL = url("https://apps.apple.com/")

    private static func url(_ string: String) -> URL {
        guard let url = URL(string: string) else {
            preconditionFailure("Invalid bundled URL: \(string)")
        }
        return url
    }
}

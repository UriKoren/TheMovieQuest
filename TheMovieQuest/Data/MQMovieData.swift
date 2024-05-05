//
//  MQTMDBData.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import Foundation

struct MQMovieData: Codable {
    let page: Int
    let results: [MQMovieDetailResult]
    let totalPages: Int
    let totalResults: Int
}

struct MQMovieDetailResult: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    //client based:
    
    //return the full image url
    var imageUrl: URL? {
        guard
            let backdropPath,
           backdropPath != "" else {
            return nil
        }

        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }
}



//{
//  "page": 1,
//  "results": [
//    {
//      "adult": false,
//      "backdrop_path": "/o3Dnwh9zCxx7uDvILfqAnPq59Jf.jpg",
//      "genre_ids": [27],
//      "id": 569367,
//      "original_language": "en",
//      "original_title": "Night Shift",
//      "overview": "Amy begins her first night shift in a hotel with a murderous past. Witnessing terrifying events and trapped within a loop, Amy must find a way to escape the flesh obsessed murderer and save residents of the hotel.",
//      "popularity": 35.901,
//      "poster_path": "/9IqVWHddRBrlQQshIIeckEzEayI.jpg",
//      "release_date": "2018-09-07",
//      "title": "Night Shift",
//      "video": false,
//      "vote_average": 5.6,
//      "vote_count": 24
//    },
//    {
//      "adult": false,
//      "backdrop_path": "/4yrOyO3N55XazHQXXYoqiiPQd40.jpg",
//      "genre_ids": [27],
//      "id": 938614,
//      "original_language": "en",
//      "original_title": "Late Night with the Devil",
//      "overview": "A live broadcast of a late-night talk show in 1977 goes horribly wrong, unleashing evil into the nation's living rooms.",
//      "popularity": 394.054,
//      "poster_path": "/u3YQJctMzFN2wAvnkmXy41bXhFv.jpg",
//      "release_date": "2024-03-19",
//      "title": "Late Night with the Devil",
//      "video": false,
//      "vote_average": 7.376,
//      "vote_count": 274
//    },
//    {
//      "adult": false,
//      "backdrop_path": null,
//      "genre_ids": [],
//      "id": 453026,
//      "original_language": "en",
//      "original_title": "Night",
//      "overview": "When Sue's cousin Genelva visits her from Suriname, they go out to a fancy club with Sue's two best friends. After having an unpleasant encounter with the club's bouncer at the door, the course of their night changes completely.",
//      "popularity": 1.793,
//      "poster_path": "/hoTpEKSA1CxmQacGBdxYcxxDh39.jpg",
//      "release_date": "2017-05-06",
//      "title": "Night",
//      "video": false,
//      "vote_average": 0,
//      "vote_count": 0
//    },
//    {
//      "adult": false,
//      "backdrop_path": null,
//      "genre_ids": [27],
//      "id": 55081,
//      "original_language": "en",
//      "original_title": "Night",
//      "overview": "Detective Mike Jericho is changing. He stops showing up for work and shuts out the people once important to him. Now, he spends all his time hanging out with his new friends, having fun, and learning how to hunt and kill innocent people. Mike is changing; and his new friends aren't quite human. Detective Jimi Cannon is searching. He's hitting the streets, fiercely looking for his best friend, Mike. Now, Jimi must enter a world of shadows and face off - guns blazing - against an enemy that won't die. He'll do everything he can to save Mike, but it will take more than courage for Jimi to survive the night!",
//      "popularity": 2.621,
//      "poster_path": "/hdsSRGm4IjCAyireS7IbEcAu1uH.jpg",
//      "release_date": "2006-11-07",
//      "title": "Night",
//      "video": false,
//      "vote_average": 2,
//      "vote_count": 1
//    },
//    {
//      "adult": false,
//      "backdrop_path": "/d2C9LnsUePTY9CaNGzNgNXchnhj.jpg",
//      "genre_ids": [16],
//      "id": 39092,
//      "original_language": "en",
//      "original_title": "Night",
//      "overview": "The moon and two owls sing to the Blue Danube Waltz, celebrating the night. Moths dance around a candle flame, fireflies glow, frogs chorus, and so forth.",
//      "popularity": 3.002,
//      "poster_path": "/82bwEXgjPncYrg8LlzKOF46NdP7.jpg",
//      "release_date": "1930-07-04",
//      "title": "Night",
//      "video": false,
//      "vote_average": 5,
//      "vote_count": 20
//    },
//    {
//      "adult": false,
//      "backdrop_path": null,
//      "genre_ids": [27],
//      "id": 590084,
//      "original_language": "en",
//      "original_title": "Night",
//      "overview": "A young girl is kidnapped by a strange man, who forces her to be the star of his sick and twisted live stream.",
//      "popularity": 1.115,
//      "poster_path": "/8yvPNCvxsPxgfQlSDQv7YvFSUZj.jpg",
//      "release_date": "2019-03-23",
//      "title": "Night",
//      "video": false,
//      "vote_average": 5.5,
//      "vote_count": 5
//    },
//    {
//      "adult": false,
//      "backdrop_path": "/5jlkyXB2sfEBb8EbGsEQTUQ9JGA.jpg",
//      "genre_ids": [16],
//      "id": 118249,
//      "original_language": "en",
//      "original_title": "Thriller Night",
//      "overview": "A Shrek parody of Michael Jackson's Thriller song and music video, with Donkey singing.",
//      "popularity": 69.407,
//      "poster_path": "/mPQei2YUIY0Ljd3O5Wy7LDuvC8S.jpg",
//      "release_date": "2011-09-13",
//      "title": "Thriller Night",
//      "video": false,
//      "vote_average": 6.811,
//      "vote_count": 82
//    },
//    {
//      "adult": false,
//      "backdrop_path": null,
//      "genre_ids": [],
//      "id": 274000,
//      "original_language": "en",
//      "original_title": "Night",
//      "overview": "A stunning and cinematic documentary, NIGHT explores the universal nature of its namesake and how the people of the world experience it. A combination of beautiful and arresting imagery that accurately captures the mystery, mood and magic of the night, this film unveils the pleasure, the pain, the reality and the fantasy behind the darkness.",
//      "popularity": 1.02,
//      "poster_path": "/jKyrB4lYL7iyMo9rIyEU37BsdmH.jpg",
//      "release_date": "2007-02-02",
//      "title": "Night",
//      "video": false,
//      "vote_average": 7,
//      "vote_count": 1
//    },
//    {
//      "adult": false,
//      "backdrop_path": null,
//      "genre_ids": [],
//      "id": 989764,
//      "original_language": "en",
//      "original_title": "Night",
//      "overview": "A loner walks in the night",
//      "popularity": 0.6,
//      "poster_path": "/npgdNKwBaoTa7TKa0Yj7tRK8j0A.jpg",
//      "release_date": "2009-04-03",
//      "title": "Night",
//      "video": false,
//      "vote_average": 0,
//      "vote_count": 0
//    },
//    {
//      "adult": false,
//      "backdrop_path": null,
//      "genre_ids": [27, 53],
//      "id": 326014,
//      "original_language": "en",
//      "original_title": "Night",
//      "overview": "Lisa is a struggling business woman working late one evening. It just happens to be the night a man seeks revenge on the lawyer who withheld evidence during his trial seven years ago.",
//      "popularity": 2.814,
//      "poster_path": null,
//      "release_date": "",
//      "title": "Night",
//      "video": false,
//      "vote_average": 0,
//      "vote_count": 0
//    },
//    {
//      "adult": false,
//      "backdrop_path": null,
//      "genre_ids": [],
//      "id": 882488,
//      "original_language": "en",
//      "original_title": "Night",
//      "overview": "Enjoy this tale of a bootlegger vampire teaming with drug underworld types battling unprepared vampire hunters. Sexy vampires, muscleman vampires, a vampire earning a living.",
//      "popularity": 1.585,
//      "poster_path": "/cKHs3M18chk9pWDDNik1ZbNsbuF.jpg",
//      "release_date": "1996-01-01",
//      "title": "Night",
//      "video": false,
//      "vote_average": 6,
//      "vote_count": 1
//    },
//    {
//      "adult": false,
//      "backdrop_path": null,
//      "genre_ids": [99],
//      "id": 587588,
//      "original_language": "es",
//      "original_title": "Night",
//      "overview": "",
//      "popularity": 0.6,
//      "poster_path": "/2h6K7xCQuqndq3z6tpxnXIOF3Hi.jpg",
//      "release_date": "2017-07-28",
//      "title": "Night",
//      "video": false,
//      "vote_average": 0,
//      "vote_count": 0
//    },
//    {
//      "adult": false,
//      "backdrop_path": "/Amvdexp1W0uqqSEkWlYjM9nDJfa.jpg",
//      "genre_ids": [16, 28, 14, 18, 10749],
//      "id": 390634,
//      "original_language": "ja",
//      "original_title": "劇場版「Fate/stay night [Heaven’s Feel]」Ⅱ.lost butterfly",
//      "overview": "The Fifth Holy Grail War continues, and the ensuing chaos results in higher stakes for all participants. Shirou Emiya continues to participate in the war, aspiring to be a hero of justice who saves everyone. He sets out in search of the truth behind a mysterious dark shadow and its murder spree, determined to defeat it.  Meanwhile, Shinji Matou sets his own plans into motion, threatening Shirou through his sister Sakura Matou. Shirou and Rin Tohsaka battle Shinji, hoping to relieve Sakura from the abuses of her brother. But the ugly truth of the Matou siblings begins to surface, and many dark secrets are exposed.",
//      "popularity": 27.276,
//      "poster_path": "/nInpnGCjhzVhsASIUAmgM1QIhYM.jpg",
//      "release_date": "2019-01-12",
//      "title": "Fate/stay night: Heaven's Feel II. Lost Butterfly",
//      "video": false,
//      "vote_average": 7.014,
//      "vote_count": 222
//    },
//    {
//      "adult": false,
//      "backdrop_path": "/v8RgWCgabyym0eVOuQJaxL4GS8p.jpg",
//      "genre_ids": [37, 53, 28],
//      "id": 1216299,
//      "original_language": "en",
//      "original_title": "The Night They Came Home",
//      "overview": "The combined force of local lawmen and Indian police aim to take down the the Rufus Buck Gang, a cold-heated band of fugitives with vengeance on their minds.",
//      "popularity": 476.673,
//      "poster_path": "/6Bd17axAG0qJ6YIU3SoootXV0Cz.jpg",
//      "release_date": "2024-01-12",
//      "title": "The Night They Came Home",
//      "video": false,
//      "vote_average": 5.5,
//      "vote_count": 13
//    },
//    {
//      "adult": false,
//      "backdrop_path": "/xfZ2u86Tui0aTKcPYcKGStzxWZv.jpg",
//      "genre_ids": [28, 16, 18, 14, 10749],
//      "id": 283984,
//      "original_language": "ja",
//      "original_title": "劇場版「Fate/stay night [Heaven’s Feel]」Ⅰ.presage flower",
//      "overview": "Shiro Emiya is a young magus who attends Homurahara Academy in Fuyuki City. One day after cleaning the Archery Dojo in his school, he catches a glimpse of a fight between superhuman beings, and he gets involved in the Holy Grail War, a ritual where magi called Masters fight each other with their Servants to win the Holy Grail. Shiro joins the battle to stop an evildoer from winning the Grail and to save innocent people, but everything goes wrong when a mysterious \"Shadow\" begins to indiscriminately kill people in Fuyuki...",
//      "popularity": 26.631,
//      "poster_path": "/6nEtmBg07DA5BWjcrmD49rxHsVQ.jpg",
//      "release_date": "2017-10-14",
//      "title": "Fate/stay night: Heaven's Feel I. Presage Flower",
//      "video": false,
//      "vote_average": 7.473,
//      "vote_count": 219
//    },
//    {
//      "adult": false,
//      "backdrop_path": "/ymIvBGhURcatDLaAzYJqxf5sUUT.jpg",
//      "genre_ids": [35, 10749],
//      "id": 1211307,
//      "original_language": "es",
//      "original_title": "Noche de Bodas",
//      "overview": "Lucía and Nico, the couple of the century, are about to say yes... although not with each other. It turns out that they both decided to get married on the same day and in the same place, but with other people.",
//      "popularity": 24.907,
//      "poster_path": "/562Feolv3s54cJn9iUhqDtFysGR.jpg",
//      "release_date": "2024-03-07",
//      "title": "Weeding Night",
//      "video": false,
//      "vote_average": 6,
//      "vote_count": 1
//    },
//    {
//      "adult": false,
//      "backdrop_path": "/lUDwMTah5nN5Sw33GfyWJKIld0U.jpg",
//      "genre_ids": [18],
//      "id": 1017438,
//      "original_language": "es",
//      "original_title": "La última noche de Sandra M.",
//      "overview": "Freely inspired by the life of the actress Sandra Mozarowsky, who died in 1977 when she fell from the terrace of her house in Madrid, the story will focus on the day before the accident, in which loneliness, fear and anguish in the face of a situation desperate mix with his dreams and ambitions.",
//      "popularity": 57.725,
//      "poster_path": "/ycBwDgJJ40dTE52fWBliqQKFD43.jpg",
//      "release_date": "2023-12-15",
//      "title": "The Last Night of Sandra M.",
//      "video": false,
//      "vote_average": 6.7,
//      "vote_count": 3
//    },
//    {
//      "adult": false,
//      "backdrop_path": "/feyYAbERTGHLQctqEPj900sTIFN.jpg",
//      "genre_ids": [28, 80, 53],
//      "id": 449992,
//      "original_language": "id",
//      "original_title": "The Night Comes for Us",
//      "overview": "After sparing a girl's life during a massacre, an elite Triad assassin is targeted by an onslaught of murderous gangsters.",
//      "popularity": 28.485,
//      "poster_path": "/8lI1p5cPqgXN2qrKZrmI3mhKBfs.jpg",
//      "release_date": "2018-10-05",
//      "title": "The Night Comes for Us",
//      "video": false,
//      "vote_average": 6.9,
//      "vote_count": 653
//    },
//    {
//      "adult": false,
//      "backdrop_path": "/gxHJdROahEY1M1uJQBvd7lG4K4X.jpg",
//      "genre_ids": [16, 28, 14, 878],
//      "id": 893712,
//      "original_language": "ja",
//      "original_title": "劇場版 ソードアート・オンライン -プログレッシブ- 冥き夕闇のスケルツォ",
//      "overview": "Over a month has passed since 10,000 users were trapped inside the \"Sword Art Online\" world. Asuna, who cleared the first floor of the floating iron castle of Aincrad, joined up with Kirito and continued her journey to reach the top floor. With the support of female Information Broker Argo, clearing the floors seemed to be progressing smoothly, but conflict erupts between two major guilds who should be working together – the top player groups ALS (the Aincrad Liberation Squad) and DKB (the Dragon Knights Brigade). And meanwhile, behind the scenes exists a mysterious figure pulling the strings…",
//      "popularity": 36.107,
//      "poster_path": "/a8B3bagkYRULdmnhgKMcxXaVcFm.jpg",
//      "release_date": "2022-10-22",
//      "title": "Sword Art Online the Movie – Progressive – Scherzo of Deep Night",
//      "video": false,
//      "vote_average": 7.699,
//      "vote_count": 166
//    },
//    {
//      "adult": false,
//      "backdrop_path": "/1S6HTRZ8HwuIM8KVNOaycN5WxwX.jpg",
//      "genre_ids": [27, 53],
//      "id": 59429,
//      "original_language": "ja",
//      "original_title": "パラノーマル・アクティビティ 第2章 TOKYO NIGHT",
//      "overview": "Koichi takes care of his sister, who has recently returned from a trip abroad in the United States as she is not well. While caring for her, he records evidence of ghosts in their home.",
//      "popularity": 24.793,
//      "poster_path": "/mh7j7XlYWo82UnQGhsxcuyolzp.jpg",
//      "release_date": "2010-11-20",
//      "title": "Paranormal Activity: Tokyo Night",
//      "video": false,
//      "vote_average": 5.982,
//      "vote_count": 412
//    }
//  ],
//  "total_pages": 474,
//  "total_results": 9468
//}

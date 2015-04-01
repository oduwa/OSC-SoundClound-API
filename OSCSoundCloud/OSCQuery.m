//
//  OSCQuery.m
//  Syren
//
//  Created by Odie Edo-Osagie on 01/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "OSCQuery.h"

@implementation OSCQuery

+ (NSArray *)searchForTrack:(NSString *)query
{
    /* Variable initialization */
    NSError* error;
    NSString *APIKey = [OSCManager sharedManager].API_KEY;
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    /* Fetch data */
    NSString *urlString = [NSString stringWithFormat:@"http://api.soundcloud.com/tracks?client_id=%@&q=%@", APIKey, [OSCManager escapeString:query]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData* data = [NSData dataWithContentsOfURL:url options:0 error:&error];
    
    if(!error){
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        /* Check if error occured within API. If no error, check that API retrned a results array */
        if([json isKindOfClass:[NSDictionary class]] && [json objectForKey:@"errors"]){
            NSLog(@"<OSCQuery> ERROR OCCURED SEARCHING FOR TRACK:%@", json[@"errors"]);
        }
        else if([json isKindOfClass:[NSArray class]]){
            /* Iterate through search results, create a model for each one and store the model for return */
            for(NSDictionary *dict in json){
                
                /* Create model */
                OSCTrack *track = [[OSCTrack alloc] init];
                
                /* Populate model */
                track.soundcloudId = dict[@"id"];
                track.createdAt = dict[@"created_at"];
                track.duration = dict[@"duration"];
                track.isCommentable = dict[@"commentable"];
                track.state = dict[@"state"];
                track.originalContentSize = dict[@"original_content_size"];
                track.lastModified = dict[@"last_modified"];
                track.sharing = dict[@"tag_list"];
                track.permalink = dict[@"permalink"];
                track.isStreamable = dict[@"streamable"];
                track.embeddableBy = dict[@"embeddable_by"];
                track.isDownloadable = dict[@"downloadable"];
                track.purchaseURL = dict[@"purchase_url"];
                track.labelId = dict[@"label_id"];
                track.genre = dict[@"genre"];
                track.title = dict[@"title"];
                track.trackDescription = dict[@"description"];
                track.labelName = dict[@"label_name"];
                track.trackRelease = dict[@"release"];
                track.trackType = dict[@"track_type"];
                track.keySignature = dict[@"key_signature"];
                track.isrc = dict[@"isrc"];
                track.videoUrl = dict[@"video_url"];
                track.bpm = dict[@"bpm"];
                track.releaseYear = dict[@"release_year"];
                track.releaseMonth = dict[@"release_month"];
                track.releaseDay = dict[@"release_day"];
                track.originalFormat = dict[@"original_format"];
                track.license = dict[@"license"];
                track.uri = dict[@"uri"];
                track.permalinkUrl = dict[@"permalink_url"];
                track.artworkUrl = dict[@"artwork_url"];
                track.waveformUrl = dict[@"waveform_url"];
                track.streamUrl = dict[@"stream_url"];
                track.playCount = dict[@"playback_count"];
                track.downloadCount = dict[@"download_count"];
                track.favouritingsCount = dict[@"favoritings_count"];
                track.commentCount = dict[@"comment_count"];
                track.attachmentsUri = dict[@"attachments_uri"];
                track.policy = dict[@"policy"];
                track.downloadCount = dict[@"download_count"];
                track.downloadUrl = dict[@"download_url"];
                
                OSCUser *user = [[OSCUser alloc] init];
                user.soundcloudID = dict[@"user"][@"id"];
                user.permalink = dict[@"user"][@"permalink"];
                user.username = dict[@"user"][@"username"];
                user.lastModified = dict[@"user"][@"last_modified"];
                user.uri = dict[@"user"][@"uri"];
                user.permalinkUrl = dict[@"user"][@"permalink_url"];
                user.avatarUrl = dict[@"user"][@"avatar_url"];
                user.soundcloudID = dict[@"user"][@"id"];
                user.soundcloudID = dict[@"user"][@"id"];
                user.soundcloudID = dict[@"user"][@"id"];
                
                track.user = user;
                
                [results addObject:track];
            }
        }
        else{
            NSLog(@"<OSCQuery> WARNING: No results found");
        }
    }
    else{
        NSLog(@"<OSCQuery> ERROR OCCURED SEARCHING FOR TRACK:%@", error);
    }
    
    
    return [NSArray arrayWithArray:results];
}

@end

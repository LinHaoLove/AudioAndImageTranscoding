//
//  ViewController.m
//  AudioAndImageTranscoding
//
//  Created by jit-mac on 16/9/2.
//  Copyright © 2016年 LLH. All rights reserved.
//

#import "ViewController.h"
#import "lame/lame.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // [self oooooooo];
}
#pragma mark 图片转码核心代码
-(void)oooooooo{
    
    UIImage *image=[UIImage imageNamed:@"123456.png"];
    NSData *data;
    
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 0.75);
    } else {
        data = UIImagePNGRepresentation(image);
        
    }
    NSString *tempPath = NSTemporaryDirectory();
    NSLog(@"%@",tempPath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"imageBox"];         //将图片存储到本地documents
    [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    [fileManager createFileAtPath:[filePath stringByAppendingString:@"/image.jpg"] contents:data attributes:nil];
    //[fileManager createFileAtPath:[filePath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
    
    
    
    #pragma mark 这个使用base64编码,可以搜一下百科解释,不用它也能转成
    //    NSString *base64Encoded = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //    NSData *nsdataFromBase64String = [[NSData alloc]initWithBase64EncodedString:base64Encoded options:0];
    //    [nsdataFromBase64String writeToFile:filePath atomically:YES];
    
    [data writeToFile:filePath atomically:YES];
    
}


#pragma mark 音频转码核心代码,不能直接调用的哈.需要你写一下路径
-(void)xxxxxx{
    NSString *cafFilePath;//caf文件路径
    NSString *mp3FilePath;//存储mp3文件的路径
    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);//音频文件被压缩,数据精度降低
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        //执行其他,后续操作
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

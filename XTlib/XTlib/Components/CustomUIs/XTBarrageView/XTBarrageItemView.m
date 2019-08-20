
#import "XTBarrageItemView.h"
#import <XTBase/XTBase.h>


@implementation XTBarrageItemView {
    //    THLabel *_contentLabel;
}

/*
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        _contentLabel = [[THLabel alloc] initWithFrame:CGRectMake(0, 0, 1, frame.size.height)];
        [_contentLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_MIDDLE]];
        [_contentLabel setTextColor:[UIColor whiteColor]];
        _contentLabel.numberOfLines = 1 ;
        
        // Demonstrate stroke.
        _contentLabel.strokeColor = [UIColor blackColor];
        _contentLabel.strokeSize = 0.5f;
        
        [self addSubview:_contentLabel];
        
        [self.layer setMasksToBounds:YES];
        [self setClipsToBounds:YES];
    }
    
    return self;
}


- (void)setAvatarUrl:(NSString *)imageUrl withContent:(NSString *)content {
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:DEFAULAVATAR];
    [_contentLabel setText:content];
    [_contentLabel sizeToFit];
    self.width = _contentLabel.width+43;
}

- (void)setAvatarWithImage:(UIImage *)image withContent:(NSString *)content {
//    [_avatarView setImage:image];
    [_contentLabel setText:content];
    [_contentLabel sizeToFit];
    self.width = _contentLabel.width+43-35;
}
- (void)setAvatarWithImageString:(NSString *)imageStr withContent:(NSString *)content {
    [self setAvatarWithImage:[UIImage imageNamed:imageStr] withContent:content];
}

- (void)setFlywordWithContent:(NSString *)content
                 AndWithColor:(UIColor *)color
                  AndWithFont:(UIFont *)font
{
    [_contentLabel setText:content];
    [_contentLabel sizeToFit];
    self.width = _contentLabel.width+43-35;
}


- (void)setFlywordWithComment:(id)comment
{
    [self setFlywordWithComment:comment
                     WithBorder:comment.isPostedImmediately] ;
}

- (void)setFlywordWithComment:(id)comment
                   WithBorder:(BOOL)hasBorder
{
    NSString *strShow = [comment.c_content minusReturnStr] ;
    
    //1 content
    [_contentLabel setText:strShow] ;
    //2 color
    UIColor *acolor = [ArticleComment getUIColorWithEnum:[ArticleComment getColorTypeWithStr:comment.c_color]] ;
    [_contentLabel setTextColor:acolor] ;
    //3 font
    UIFont *afont = [ArticleComment getUIFontWithEnum:[ArticleComment getFontTypeWithStr:comment.c_size]] ;
    [_contentLabel setFont:afont] ;
    [_contentLabel sizeToFit] ;
    //4 border
    _contentLabel.layer.borderWidth = hasBorder ? 1.0 : 0.0 ;
    _contentLabel.layer.borderColor = hasBorder ? acolor.CGColor : nil ;
    //5 width
    self.width = _contentLabel.width + 43.0f - 35.0f ;
    //6 set str will show
    self.strWillShow = strShow ;
}
*/
@end

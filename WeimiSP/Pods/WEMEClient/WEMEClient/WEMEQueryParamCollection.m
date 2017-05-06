#import "WEMEQueryParamCollection.h"

@implementation WEMEQueryParamCollection

@synthesize values = _values;
@synthesize format = _format;

- (id) initWithValuesAndFormat: (NSArray*) values
                        format: (NSString*) format {
    _values = values;
    _format = format;

    return self;
}

@end

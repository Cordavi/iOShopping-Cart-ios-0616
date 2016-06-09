//
//  FISShoppingCart.m
//  iOShoppingCart
//
//  Created by Michael Amundsen on 6/8/16.
//  Copyright © 2016 FIS. All rights reserved.
//

#import "FISShoppingCart.h"

@implementation FISShoppingCart

- (NSUInteger)calculateTotalPriceInCents {
    NSUInteger itemTotal = 0;
    for (FISItem *item in self.items) {
        itemTotal += item.priceInCents;
    }
    return itemTotal;
}

- (void)addItem:(FISItem *)item {
    [self.items addObject:item];
}

- (void)removeItem:(FISItem *)item {
    NSUInteger indexOfItem = [self.items indexOfObject:item];
    [self.items removeObjectAtIndex:indexOfItem];
}

- (void)removeAllItemsLikeItem:(FISItem *)item {
    [self.items removeObject:item];
}

- (void)sortItemsByNameAsc {
    NSSortDescriptor *sortAsc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [self.items sortUsingDescriptors:@[sortAsc]];
}

- (void)sortItemsByNameDesc {
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    [self.items sortUsingDescriptors:@[sortDesc]];
}

- (void)sortItemsByPriceInCentsAsc {
    NSSortDescriptor *sortAscByPrice = [NSSortDescriptor sortDescriptorWithKey:@"priceInCents" ascending:YES];
    [self.items sortUsingDescriptors:@[sortAscByPrice]];
}

- (void)sortItemsByPriceInCentsDesc {
    NSSortDescriptor *sortDescByPrice = [NSSortDescriptor sortDescriptorWithKey:@"priceInCents" ascending:NO];
    [self.items sortUsingDescriptors:@[sortDescByPrice]];
}

- (NSArray *)allItemsWithName:(NSString *)name {
    NSMutableArray *itemsWhoContainName = [@[] mutableCopy];
    for (FISItem *item in self.items) {
        if ([name containsString:item.name]) {
            [itemsWhoContainName addObject:item];
        }
    }
    return itemsWhoContainName;
}

- (NSArray *)allItemsWithMinimumPriceInCents:(NSUInteger)price {
    NSPredicate *pricePredicate = [NSPredicate predicateWithFormat:@"priceInCents >= %lu", price];
    return [self.items filteredArrayUsingPredicate:pricePredicate];
}

- (NSArray *)allItemsWithMaximumPriceInCents:(NSUInteger)price {
    NSPredicate *pricePredicate = [NSPredicate predicateWithFormat:@"priceInCents <= %lu", price];
    return [self.items filteredArrayUsingPredicate:pricePredicate];
}

@end

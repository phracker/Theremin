/*
 Copyright (C) 2006-2007  Patrik Weiskircher
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
 MA 02110-1301, USA.
 */

#import "PWWindow.h"
#import "AppGlobalHotkeyController.h"

@implementation PWWindow
- (void) setTargetForSpace:(id)target withSelector:(SEL)selector {
	mSpaceTarget = target;
	mSpaceSelector = selector;
}

- (BOOL)performKeyEquivalent:(NSEvent *)theEvent {
	if ([[theEvent characters] isEqualTo:@" "]) {
		if ([[self firstResponder] isKindOfClass:[NSButton class]] == NO) {
			if (mSpaceTarget != nil) {
				[mSpaceTarget performSelector:mSpaceSelector withObject:self];
				return YES;
			}
		}
	}
	
	if (mUseGlobalHotkeys == YES)
		if ([[AppGlobalHotkeyController instance] performKeyEquivalent:theEvent onWindow:self])
			return YES;
	
	return [super performKeyEquivalent:theEvent];
}

- (void) setUseGlobalHotkeys:(BOOL)aValue {
	mUseGlobalHotkeys = aValue;
}

- (BOOL) useGlobalHotkeys {
	return mUseGlobalHotkeys;
}

- (NSView *) getLastLeftHit {
	return _lastLeftHit;
}

- (NSView *) getLastRightHit {
	return _lastRightHit;
}

@end

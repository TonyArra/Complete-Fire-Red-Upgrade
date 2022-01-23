#include "../defines.h"
#include "../../include/constants/event_objects.h"

#define EVENT_OBJ_PAL_TAG_NONE 0x1102
#define gEventObjectBaseOam_16x16 ((const struct OamData*) 0x83A36F8)
#define gEventObjectBaseOam_16x32 ((const struct OamData*) 0x83A3710)
#define gEventObjectBaseOam_32x32 ((const struct OamData*) 0x83A3718)
#define gEventObjectBaseOam_64x64 ((const struct OamData*) 0x83A3720)
#define gEventObjectSpriteOamTables_16x16 ((const struct SubspriteTable*) 0x83A3748)
#define gEventObjectSpriteOamTables_16x32 ((const struct SubspriteTable*) 0x83A379C)
#define gEventObjectSpriteOamTables_32x32 ((const struct SubspriteTable*) 0x83A37F0)
#define gEventObjectSpriteOamTables_64x64 ((const struct SubspriteTable*) 0x83A38D0)
#define gEventObjectImageAnimTable_PlayerNormal ((const union AnimCmd* const*) 0x83A3470)
#define gEventObjectImageAnimTable_Standard ((const union AnimCmd* const*) 0x83A3368)
#define gEventObjectImageAnimTable_Surfing ((const union AnimCmd* const*) 0x83A3584)
#define gEventObjectImageAnimTable_FieldMove ((const union AnimCmd* const*) 0x83A3638)
#define gEventObjectImageAnimTable_Fishing ((const union AnimCmd* const*) 0x83A3668)
#define gEventObjectImageAnimTable_VsSeekerBike ((const union AnimCmd* const*) 0x83A3640)

// Garticmon Expanded Overworld Sprites

extern const u8 gEventObjectPic_PlayerSleepingMaleTiles[];
extern const u8 gEventObjectPic_PlayerSleepingFemaleTiles[];

// For some reason, having less than frames for the first entry
// causes graphic glitches on later sprites declared here 
static const struct SpriteFrameImage gEventObjectPicTable_PlayerSleepingMale[] =
{
    overworld_frame(gEventObjectPic_PlayerSleepingMaleTiles, 2, 4, 0),
    overworld_frame(gEventObjectPic_PlayerSleepingMaleTiles, 2, 4, 1),
    overworld_frame(gEventObjectPic_PlayerSleepingMaleTiles, 2, 4, 0),
    overworld_frame(gEventObjectPic_PlayerSleepingMaleTiles, 2, 4, 1),
    overworld_frame(gEventObjectPic_PlayerSleepingMaleTiles, 2, 4, 0),
    overworld_frame(gEventObjectPic_PlayerSleepingMaleTiles, 2, 4, 1),
    overworld_frame(gEventObjectPic_PlayerSleepingMaleTiles, 2, 4, 0),
    overworld_frame(gEventObjectPic_PlayerSleepingMaleTiles, 2, 4, 1),
};

static const struct SpriteFrameImage gEventObjectPicTable_PlayerSleepingFemale[] =
{
    overworld_frame(gEventObjectPic_PlayerSleepingFemaleTiles, 2, 4, 0),
    overworld_frame(gEventObjectPic_PlayerSleepingFemaleTiles, 2, 4, 1),
    overworld_frame(gEventObjectPic_PlayerSleepingFemaleTiles, 2, 4, 0),
    overworld_frame(gEventObjectPic_PlayerSleepingFemaleTiles, 2, 4, 1),
    overworld_frame(gEventObjectPic_PlayerSleepingFemaleTiles, 2, 4, 0),
    overworld_frame(gEventObjectPic_PlayerSleepingFemaleTiles, 2, 4, 1),
    overworld_frame(gEventObjectPic_PlayerSleepingFemaleTiles, 2, 4, 0),
    overworld_frame(gEventObjectPic_PlayerSleepingFemaleTiles, 2, 4, 1),
};

const struct EventObjectGraphicsInfo gEventObjectGraphicsInfo_PlayerSleepingMale =
{
    .tileTag = 0xFFFF,
    .paletteTag1 = 0x1119,
    .paletteTag2 = EVENT_OBJ_PAL_TAG_NONE,
    .size = (16 * 32) / 2,
    .width = 16,
    .height = 32,
    .paletteSlot = 0,
    .shadowSize = SHADOW_SIZE_M,
    .inanimate = FALSE,
    .disableReflectionPaletteLoad = FALSE,
    .tracks = TRACKS_FOOT,
    .gender = MALE,
    .oam = gEventObjectBaseOam_16x32,
    .subspriteTables = gEventObjectSpriteOamTables_16x32,
    .anims = gEventObjectImageAnimTable_Standard,
    .images = gEventObjectPicTable_PlayerSleepingMale,
    .affineAnims = gDummySpriteAffineAnimTable,
};

const struct EventObjectGraphicsInfo gEventObjectGraphicsInfo_PlayerSleepingFemale =
{
    .tileTag = 0xFFFF,
    .paletteTag1 = 0x1120,
    .paletteTag2 = EVENT_OBJ_PAL_TAG_NONE,
    .size = (16 * 32) / 2,
    .width = 16,
    .height = 32,
    .paletteSlot = 0,
    .shadowSize = SHADOW_SIZE_M,
    .inanimate = FALSE,
    .disableReflectionPaletteLoad = FALSE,
    .tracks = TRACKS_FOOT,
    .gender = FEMALE,
    .oam = gEventObjectBaseOam_16x32,
    .subspriteTables = gEventObjectSpriteOamTables_16x32,
    .anims = gEventObjectImageAnimTable_Standard,
    .images = gEventObjectPicTable_PlayerSleepingFemale,
    .affineAnims = gDummySpriteAffineAnimTable,
};

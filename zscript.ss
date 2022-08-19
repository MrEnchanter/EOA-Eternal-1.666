class DE_Zombieman : EDE_Monster replaces Zombieman
{
	Default
	{
		Health 20;
		PainChance 200;
		SeeSound "grunt/sight";
		AttackSound "grunt/attack";
		PainSound "grunt/pain";
		DeathSound "grunt/death";
		ActiveSound "grunt/active";
		Obituary "$OB_ZOMBIE";
		Tag "$FN_ZOMBIE";
		DropItem "Clip";
		Species "Zombieman";
	}
	States
	{
		Spawn:
			NZOM A 10 A_Look;
			Loop;
		See:
			NZOM AABBCCDD 3 A_NTMChase;
			Loop;
		Missile:
			NZOM E 0
			{
				int ran = Random(0, 256);
				if ((G_SkillPropertyInt(7) == 5 && ran <= 20) || (G_SkillPropertyInt(7) == 4 && ran <= 10))
					return (FindState("Grenade"));
				return (FindState("StartMissile"));
			}
			Stop;
		StartMissile:
			NZOM E 10 A_FaceTarget;
			NZOM F 2 Bright A_NTMPosAttack;
			NZOM E 2 A_FaceTarget;
			NZOM F 2 Bright A_NTMPosAttack;
			NZOM E 2 A_FaceTarget;
			NZOM F 2 Bright A_NTMPosAttack;
			NZOM E 8;
			Goto See;
		Grenade:
			NZOM V 0 A_JumpIfCloser(960, 1, true);
			Goto Missile;
			NZOM VW 6 A_FaceTarget;
			NZOM X 6 A_ThrowGrenade("EDE_Explosion", 25, 8, 4);
			NZOM Y 6;
			Goto See;
		Pain:
			NZOM G 3;
			NZOM G 3 A_Pain;
			NZOM G 0 A_JumpIf((health <= 10 && Random(0, 1)), "Duck");
			Goto See;
		Duck:
			NZOM S Random(10, 30)
			{
				painChance = 0;
			}
			NZOM T 10
			{
				if (Random(0, 1))
					SetStateLabel("See");
				A_FaceTarget();
			}
			NZOM U 2 Bright A_NTMPosAttack;
			NZOM T 2 A_FaceTarget;
			NZOM U 2 Bright A_NTMPosAttack;
			NZOM T 2 A_FaceTarget;
			NZOM U 2 Bright A_NTMPosAttack;
			NZOM T 8;
			NZOM T 0
			{
				painChance = default.painChance;
			}
			Goto See;
		Death:
			NZOM H 5;
			NZOM I 5 A_Scream;
			NZOM J 5 A_NoBlocking;
			NZOM K 5;
			NZOM L 0;
			#### # -1;
			Stop;
		Death.Saw:
			NZOM MMMMM 10 A_SpawnItemEx("Blood", 0, 0, 32, Random(-4, 4), Random(-4, 4), Random(0, 2));
			NZOM N 7 A_Scream;
			NZOM O 7 A_NoBlocking;
			NZOM PQ 7;
			NZOM R 0;
		Bleed:
			#### # 0 A_Jump(96, 3);
			#### ### 3 A_SpawnItemEx("Blood", 0, 0, 0, Random(-3, 3), Random(-3, 3), Random(10, 5), failchance: 56);
			#### # Random(35, 70) A_Jump(96, 1);
			Goto Bleed + 1;
			#### # -1;
			Stop;
		XDeath:
			NMGI A 5 A_XScream;
			NMGI B 5 A_NoBlocking;
			NMGI CDEFG 5;
			NMGI H -1;
			Stop;
		Raise:
			NZOM LKJIH 5;
			Goto See;
	}
	void A_NTMPosAttack()
	{
		A_CustomBulletAttack(30, 0, 1, Random(1,5), "BulletPuff", 0, CBAF_NORANDOM);
	}
}
class DE_SSGuard : DE_Zombieman replaces WolfensteinSS
{
	Default
	{
		yScale 0.75;
		xScale 0.9;
		Health 50;
		PainChance 170;
		Height 64;
		Radius 18;
		SeeSound "wolfss/sight";
		ActiveSound "wolfss/active";
		PainSound "wolfss/pain";
		DeathSound "wolfss/death";
		Obituary "$OB_WOLFSS";
		Tag "$FN_WOLFSS";
		Species "WolfensteinSS";
	}
	States
	{
		Spawn:
			NSSN N 10 A_Look;
			Loop;
		See:
			NSSN AABBCCDD 3 A_NTMChase;
			Loop;
		Missile:
			NZOM E 0
			{
				int ran = Random(0, 256);
				if (fullMod)
				{
					if (CVar.FindCVar("sv_ntm_grenadiers").GetBool())
						if ((G_SkillPropertyInt(7) == 4 && ran <= 20) || (G_SkillPropertyInt(7) == 3 && ran <= 10))
							return (FindState("Grenade"));
				}
				else
					if ((G_SkillPropertyInt(7) == 5 && ran <= 20) || (G_SkillPropertyInt(7) == 4 && ran <= 10))
						return (FindState("Grenade"));
				return (FindState("StartMissile"));
			}
			Stop;
		StartMissile:
			NSSN F 15 A_FaceTarget;
			NSSN G 3 Bright A_SSAttack;
			NSSN F 3 A_FaceTarget;
			NSSN G 3 Bright A_SSAttack;
			NSSN F 3 A_FaceTarget;
			NSSN G 3 Bright A_SSAttack;
			NSSN F 3 A_FaceTarget;
			NSSN F 0 A_CPosRefire;
			Goto StartMissile + 1;
		Grenade:
			NSSN E 0 A_JumpIfCloser(960, 1, true);
			Goto Missile;
			NSSN EOP 5 A_FaceTarget;
			NSSN Q 5 A_ThrowGrenade("EDE_Explosion", 25, 8, 4);
			Goto See;
		Pain:
			NSSN H 3;
			NSSN H 3 A_Pain;
			Goto See;
		Death:
			NSSN I 5;
			NSSN J 5 A_Scream;
			NSSN K 5 A_NoBlocking;
			NSSN L 5;
			NSSN M 0;
			#### # -1;
			Stop;
		Raise:
			NSSN MLKJI 5;
			Goto See;
	}
	void A_SSAttack()
	{
		A_PlaySound("weapons/pistol", Chan_Weapon);
		A_CustomBulletAttack(36, 0, 1, random(1, 5) * 1.8, "BulletPuff", 0, CBAF_NoRandom);
	}
}
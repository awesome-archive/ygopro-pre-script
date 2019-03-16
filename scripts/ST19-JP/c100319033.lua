--サイバネット・カスケード
--
--Script by mercury233
function c100319033.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c100319033.target)
	e1:SetOperation(c100319033.activate)
	c:RegisterEffect(e1)
end
function c100319033.cfilter(c)
	return c:IsType(TYPE_LINK) and c:IsSummonType(SUMMON_TYPE_LINK)
end
function c100319033.spfilter(c,e,tp,g)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and g and g:IsContains(c)
end
function c100319033.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local lc=eg:Filter(c100319033.cfilter,nil):GetFirst()
	if chkc then return chkc:IsControler(tp) and c100319033.spfilter(chkc,e,tp,lc:GetMaterial()) end
	if chk==0 then return lc and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c100319033.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,lc:GetMaterial()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c100319033.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,lc:GetMaterial())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c100319033.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end